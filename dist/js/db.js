/**
 * IndexedDB storage utility for bulky objects (Typst SVG render cache & course states).
 * Handles quota limits, LRU pruning, and provides graceful fallback when IDB is unavailable.
 */

const DB_NAME = "lern_db";
const DB_VERSION = 1;
const STORE_RENDER_CACHE = "render_cache";
const STORE_COURSE_STATES = "course_states";

export const MAX_SVG_CACHE_ENTRIES = 500;
const PRUNE_RATIO = 0.2; // Evict oldest 20% when capacity reached

let dbPromise = null;

export function isIdbSupported() {
    try {
        return typeof indexedDB !== "undefined" && indexedDB !== null;
    } catch {
        return false;
    }
}

export function getDb() {
    if (!isIdbSupported()) return Promise.resolve(null);
    if (dbPromise) return dbPromise;

    dbPromise = new Promise((resolve) => {
        try {
            const request = indexedDB.open(DB_NAME, DB_VERSION);

            request.onupgradeneeded = (event) => {
                const db = event.target.result;
                if (!db.objectStoreNames.contains(STORE_RENDER_CACHE)) {
                    const renderStore = db.createObjectStore(STORE_RENDER_CACHE, { keyPath: "key" });
                    renderStore.createIndex("lastAccessed", "lastAccessed", { unique: false });
                }
                if (!db.objectStoreNames.contains(STORE_COURSE_STATES)) {
                    const stateStore = db.createObjectStore(STORE_COURSE_STATES, { keyPath: "courseName" });
                    stateStore.createIndex("updatedAt", "updatedAt", { unique: false });
                }
            };

            request.onsuccess = (event) => {
                resolve(event.target.result);
            };

            request.onerror = (err) => {
                console.warn("[IDB] Failed to open database:", err);
                resolve(null);
            };
        } catch (e) {
            console.warn("[IDB] Exception opening database:", e);
            resolve(null);
        }
    });

    return dbPromise;
}

/**
 * Retrieve cached Typst SVG by cache key. Updates lastAccessed timestamp.
 */
export async function getSvgFromDb(key) {
    if (!key) return null;
    const db = await getDb();
    if (!db) return null;

    return new Promise((resolve) => {
        try {
            const tx = db.transaction(STORE_RENDER_CACHE, "readwrite");
            const store = tx.objectStore(STORE_RENDER_CACHE);
            const req = store.get(key);

            req.onsuccess = () => {
                const record = req.result;
                if (record && record.svg) {
                    // Update access timestamp for LRU
                    record.lastAccessed = Date.now();
                    try {
                        store.put(record);
                    } catch {}
                    resolve(record.svg);
                } else {
                    resolve(null);
                }
            };

            req.onerror = () => resolve(null);
        } catch {
            resolve(null);
        }
    });
}

let writeCounter = 0;

/**
 * Save rendered Typst SVG to persistent IndexedDB cache.
 * Triggers LRU batch pruning if entry count exceeds MAX_SVG_CACHE_ENTRIES.
 */
export async function saveSvgToDb(key, svg) {
    if (!key || !svg) return false;
    const db = await getDb();
    if (!db) return false;

    return new Promise((resolve) => {
        try {
            const tx = db.transaction(STORE_RENDER_CACHE, "readwrite");
            const store = tx.objectStore(STORE_RENDER_CACHE);
            const record = {
                key,
                svg,
                lastAccessed: Date.now(),
                size: svg.length
            };
            const req = store.put(record);

            req.onsuccess = () => {
                writeCounter++;
                // Check cache size periodically every 15 writes
                if (writeCounter % 15 === 0) {
                    checkAndPruneCache(db, MAX_SVG_CACHE_ENTRIES, PRUNE_RATIO);
                }
                resolve(true);
            };

            req.onerror = (err) => {
                console.warn("[IDB] Failed to write SVG cache:", err);
                resolve(false);
            };
        } catch {
            resolve(false);
        }
    });
}

/**
 * Prune oldest entries from render_cache if total count exceeds maxEntries.
 */
export async function checkAndPruneCache(dbInstance = null, maxEntries = MAX_SVG_CACHE_ENTRIES, ratio = PRUNE_RATIO) {
    const db = dbInstance || (await getDb());
    if (!db) return 0;

    return new Promise((resolve) => {
        try {
            const tx = db.transaction(STORE_RENDER_CACHE, "readwrite");
            const store = tx.objectStore(STORE_RENDER_CACHE);
            const countReq = store.count();

            countReq.onsuccess = () => {
                const total = countReq.result;
                if (total <= maxEntries) {
                    return resolve(0);
                }

                const toDeleteCount = Math.max(1, Math.floor(maxEntries * ratio));
                const index = store.index("lastAccessed");
                const cursorReq = index.openCursor(); // Ascending order: oldest first
                let deleted = 0;

                cursorReq.onsuccess = (e) => {
                    const cursor = e.target.result;
                    if (cursor && deleted < toDeleteCount) {
                        cursor.delete();
                        deleted++;
                        cursor.continue();
                    } else {
                        resolve(deleted);
                    }
                };

                cursorReq.onerror = () => resolve(deleted);
            };

            countReq.onerror = () => resolve(0);
        } catch {
            resolve(0);
        }
    });
}

/**
 * Persist course state snapshot in IndexedDB.
 */
export async function saveCourseStateDb(courseName, state) {
    if (!courseName || !state) return false;
    const db = await getDb();
    if (!db) return false;

    return new Promise((resolve) => {
        try {
            const tx = db.transaction(STORE_COURSE_STATES, "readwrite");
            const store = tx.objectStore(STORE_COURSE_STATES);
            const req = store.put({
                courseName,
                state,
                updatedAt: Date.now()
            });

            req.onsuccess = () => resolve(true);
            req.onerror = () => resolve(false);
        } catch {
            resolve(false);
        }
    });
}

/**
 * Load course state snapshot from IndexedDB.
 */
export async function loadCourseStateDb(courseName) {
    if (!courseName) return null;
    const db = await getDb();
    if (!db) return null;

    return new Promise((resolve) => {
        try {
            const tx = db.transaction(STORE_COURSE_STATES, "readonly");
            const store = tx.objectStore(STORE_COURSE_STATES);
            const req = store.get(courseName);

            req.onsuccess = () => {
                const res = req.result;
                resolve(res && res.state ? res.state : null);
            };
            req.onerror = () => resolve(null);
        } catch {
            resolve(null);
        }
    });
}

/**
 * Delete course state snapshot from IndexedDB.
 */
export async function deleteCourseStateDb(courseName) {
    if (!courseName) return false;
    const db = await getDb();
    if (!db) return false;

    return new Promise((resolve) => {
        try {
            const tx = db.transaction(STORE_COURSE_STATES, "readwrite");
            const store = tx.objectStore(STORE_COURSE_STATES);
            const req = store.delete(courseName);

            req.onsuccess = () => resolve(true);
            req.onerror = () => resolve(false);
        } catch {
            resolve(false);
        }
    });
}

/**
 * Clear all stores in IndexedDB by deleting the database.
 */
export async function clearDb() {
    if (!isIdbSupported()) return false;

    // Close any active open connection before deleting database
    if (dbPromise) {
        try {
            const db = await dbPromise;
            if (db) db.close();
        } catch {}
        dbPromise = null;
    }

    return new Promise((resolve) => {
        try {
            const req = indexedDB.deleteDatabase(DB_NAME);
            req.onsuccess = () => resolve(true);
            req.onerror = () => resolve(false);
            req.onblocked = () => {
                // If blocked by another connection, resolve false
                resolve(false);
            };
        } catch {
            resolve(false);
        }
    });
}

/**
 * Calculate actual data payload bytes stored in IndexedDB.
 */
export async function getDbPayloadSize() {
    if (!isIdbSupported()) return 0;
    const db = await getDb();
    if (!db) return 0;

    return new Promise((resolve) => {
        try {
            const tx = db.transaction([STORE_RENDER_CACHE, STORE_COURSE_STATES], "readonly");
            let total = 0;

            const reqRender = tx.objectStore(STORE_RENDER_CACHE).openCursor();
            reqRender.onsuccess = (e) => {
                const cursor = e.target.result;
                if (cursor) {
                    const record = cursor.value;
                    total += (cursor.key ? String(cursor.key).length : 0) * 2;
                    total += (record?.svg?.length || 0) * 2;
                    cursor.continue();
                }
            };

            const reqState = tx.objectStore(STORE_COURSE_STATES).openCursor();
            reqState.onsuccess = (e) => {
                const cursor = e.target.result;
                if (cursor) {
                    total += (cursor.key ? String(cursor.key).length : 0) * 2;
                    try {
                        total += JSON.stringify(cursor.value?.state || {}).length * 2;
                    } catch {}
                    cursor.continue();
                }
            };

            tx.oncomplete = () => resolve(total);
            tx.onerror = () => resolve(0);
        } catch {
            resolve(0);
        }
    });
}

/**
 * Estimate storage usage using navigator.storage.estimate() if available.
 */
export async function getStorageEstimate() {
    if (typeof navigator !== "undefined" && navigator.storage && navigator.storage.estimate) {
        try {
            return await navigator.storage.estimate();
        } catch {
            return null;
        }
    }
    return null;
}
