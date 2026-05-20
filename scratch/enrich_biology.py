import json
import sqlite3
import httpx
import re

LIBRARY_PATH = "content/biology/växtkännedom/questions/library.json"
DB_PATH = "content/biology/växtkännedom/questions/plants_gallery.db"


def clean_latin_name(name):
    # Remove everything from the first single quote onwards
    if "'" in name:
        name = name.split("'")[0].strip()
    # Remove "Gruppen" or "-Gruppen"
    name = re.sub(r"\(?-?Gruppen\)?", "", name).strip()
    # Remove "var.", "subsp.", "f.", "subsp"
    name = re.sub(r"\s(var\.|subsp\.|f\.|subsp)\s", " ", name).strip()
    # Remove "x" (hybrid marker) if it's standalone
    name = re.sub(r"\sx\s", " ", name).strip()
    return " ".join(name.split())


async def fetch_photo(client, latin_name):
    # Try full name first
    params = {"q": latin_name, "per_page": 1, "is_active": "true"}
    try:
        response = await client.get(
            "https://api.inaturalist.org/v1/taxa", params=params
        )
        data = response.json()
        if data["results"]:
            taxon = data["results"][0]
            if taxon.get("default_photo"):
                return taxon["default_photo"]["medium_url"]
    except Exception as e:
        print(f"Error fetching {latin_name}: {e}")

    # Try cleaned name
    cleaned = clean_latin_name(latin_name)
    if cleaned != latin_name and cleaned:
        print(f"Falling back to cleaned name: {cleaned}")
        params["q"] = cleaned
        try:
            response = await client.get(
                "https://api.inaturalist.org/v1/taxa", params=params
            )
            data = response.json()
            if data["results"]:
                taxon = data["results"][0]
                if taxon.get("default_photo"):
                    return taxon["default_photo"]["medium_url"]
        except Exception as e:
            print(f"Error fetching cleaned {cleaned}: {e}")

    # Try Genus species (first two words)
    words = cleaned.split()
    if len(words) > 2:
        genus_species = " ".join(words[:2])
        print(f"Falling back to Genus species: {genus_species}")
        params["q"] = genus_species
        try:
            response = await client.get(
                "https://api.inaturalist.org/v1/taxa", params=params
            )
            data = response.json()
            if data["results"]:
                taxon = data["results"][0]
                if taxon.get("default_photo"):
                    return taxon["default_photo"]["medium_url"]
        except Exception as e:
            print(f"Error fetching genus_species {genus_species}: {e}")

    # Try Genus only (first word)
    if words:
        genus = words[0]
        print(f"Falling back to Genus only: {genus}")
        params["q"] = genus
        try:
            response = await client.get(
                "https://api.inaturalist.org/v1/taxa", params=params
            )
            data = response.json()
            if data["results"]:
                taxon = data["results"][0]
                if taxon.get("default_photo"):
                    return taxon["default_photo"]["medium_url"]
        except Exception as e:
            print(f"Error fetching genus {genus}: {e}")

    return None


async def main():
    with open(LIBRARY_PATH, "r", encoding="utf-8") as f:
        plants = json.load(f)

    # Initialize DB
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS plants (
            common_name TEXT,
            latin_name TEXT PRIMARY KEY,
            photo_url TEXT
        )
    """)
    conn.commit()

    async with httpx.AsyncClient(timeout=20.0) as client:
        for plant in plants:
            latin_name = plant["latin_name"]
            common_name = plant["common_name"]

            # Check if we already have a unique photo in DB
            cursor.execute(
                "SELECT photo_url FROM plants WHERE latin_name = ?", (latin_name,)
            )
            res = cursor.fetchone()

            # If we have a placeholder or missing photo, fetch it
            # Current placeholders seem to be repeating 27342760
            is_placeholder = "27342760" in (
                plant.get("photo_url") or ""
            ) or not plant.get("photo_url")

            if is_placeholder or not res:
                print(f"Fetching photo for {latin_name}...")
                photo_url = await fetch_photo(client, latin_name)
                if photo_url:
                    print(f"Found: {photo_url}")
                    plant["photo_url"] = photo_url
                    cursor.execute(
                        "INSERT OR REPLACE INTO plants (common_name, latin_name, photo_url) VALUES (?, ?, ?)",
                        (common_name, latin_name, photo_url),
                    )
                    conn.commit()
                else:
                    print(f"No photo found for {latin_name}")

                # Rate limiting
                await asyncio.sleep(0.5)
            else:
                # Use stored photo if available and not updated in plant dict
                if res[0]:
                    plant["photo_url"] = res[0]

    # Save updated library
    with open(LIBRARY_PATH, "w", encoding="utf-8") as f:
        json.dump(plants, f, indent=2, ensure_ascii=False)

    conn.close()
    print("Enrichment complete.")


if __name__ == "__main__":
    import asyncio

    asyncio.run(main())
