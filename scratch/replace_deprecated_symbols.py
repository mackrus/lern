import os

content_dir = "/home/mac/Projects/lern/content"

count = 0
for root, dirs, files in os.walk(content_dir):
    for file in files:
        if file.endswith(".typ"):
            filepath = os.path.join(root, file)
            with open(filepath, "r", encoding="utf-8") as f:
                content = f.read()

            new_content = content.replace("angle.l", "chevron.l").replace(
                "angle.r", "chevron.r"
            )

            if new_content != content:
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(new_content)
                print(f"Updated: {filepath}")
                count += 1

print(f"Successfully updated {count} files!")
