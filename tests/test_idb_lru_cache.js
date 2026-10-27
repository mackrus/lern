import assert from "node:assert/strict";
import { LruCache } from "../dist/js/lru-cache.js";
import { safeLocalStorageSet } from "../dist/js/state.js";
import * as db from "../dist/js/db.js";

console.log("=== RUNNING LRU CACHE & STORAGE PERSISTENCE TEST SUITE ===");

// 1. LRU Cache In-Memory Tests
console.log("\n[TEST 1] LruCache In-Memory Eviction & MRU Ordering...");
{
    const cache = new LruCache(3);
    assert.strictEqual(cache.size, 0);

    cache.set("k1", "v1");
    cache.set("k2", "v2");
    cache.set("k3", "v3");
    assert.strictEqual(cache.size, 3);
    assert.strictEqual(cache.has("k1"), true);
    assert.strictEqual(cache.has("k2"), true);
    assert.strictEqual(cache.has("k3"), true);

    // Access k1 to make it most-recently used
    const v1 = cache.get("k1");
    assert.strictEqual(v1, "v1");

    // Insert k4. Oldest item was k2, so k2 should be evicted!
    cache.set("k4", "v4");
    assert.strictEqual(cache.size, 3);
    assert.strictEqual(cache.has("k2"), false, "k2 should have been evicted as LRU");
    assert.strictEqual(cache.has("k1"), true, "k1 should remain because it was accessed");
    assert.strictEqual(cache.has("k3"), true, "k3 should remain");
    assert.strictEqual(cache.has("k4"), true, "k4 should exist");

    // Overwrite existing key k3
    cache.set("k3", "v3_updated");
    // Insert k5. Oldest was k1, so k1 should be evicted!
    cache.set("k5", "v5");
    assert.strictEqual(cache.has("k1"), false, "k1 should have been evicted");
    assert.strictEqual(cache.has("k3"), true);
    assert.strictEqual(cache.get("k3"), "v3_updated");
    assert.strictEqual(cache.has("k4"), true);
    assert.strictEqual(cache.has("k5"), true);

    // Delete and Clear
    assert.strictEqual(cache.delete("k4"), true);
    assert.strictEqual(cache.size, 2);
    cache.clear();
    assert.strictEqual(cache.size, 0);
    assert.strictEqual(cache.get("k3"), undefined);

    console.log("  ✓ PASS: LruCache correctly enforces capacity and LRU eviction order");
}

// 2. safeLocalStorageSet Error & Quota Handling
console.log("\n[TEST 2] safeLocalStorageSet Quota & Error Handling...");
{
    const mockStorage = new Map();
    let throwQuota = false;

    globalThis.localStorage = {
        setItem: (k, v) => {
            if (throwQuota) {
                const err = new Error("Quota exceeded");
                err.name = "QuotaExceededError";
                err.code = 22;
                throw err;
            }
            mockStorage.set(k, String(v));
        },
        getItem: (k) => mockStorage.get(k) || null,
        removeItem: (k) => mockStorage.delete(k),
        clear: () => mockStorage.clear()
    };

    // Normal set
    const ok1 = safeLocalStorageSet("test_key", "test_val");
    assert.strictEqual(ok1, true);
    assert.strictEqual(mockStorage.get("test_key"), "test_val");

    // Trigger QuotaExceededError
    throwQuota = true;
    const ok2 = safeLocalStorageSet("test_large", "huge_payload");
    assert.strictEqual(ok2, false, "Must catch QuotaExceededError and return false without crashing");

    console.log("  ✓ PASS: safeLocalStorageSet safely handles QuotaExceededError");
}

// 3. Graceful Fallback When IndexedDB is Not Present
console.log("\n[TEST 3] db.js Graceful Fallback when IndexedDB is Absent...");
{
    // In Node without IDB polyfill, db.isIdbSupported() must be false
    assert.strictEqual(db.isIdbSupported(), false);

    const resGet = await db.getSvgFromDb("some:key");
    assert.strictEqual(resGet, null);

    const resSave = await db.saveSvgToDb("some:key", "<svg></svg>");
    assert.strictEqual(resSave, false);

    const resStateSave = await db.saveCourseStateDb("Physics", { score: 10 });
    assert.strictEqual(resStateSave, false);

    const resStateLoad = await db.loadCourseStateDb("Physics");
    assert.strictEqual(resStateLoad, null);

    const resPrune = await db.checkAndPruneCache();
    assert.strictEqual(resPrune, 0);

    const resClear = await db.clearDb();
    assert.strictEqual(resClear, false);

    const resPayload = await db.getDbPayloadSize();
    assert.strictEqual(resPayload, 0);

    const resEst = await db.getStorageEstimate();
    assert.strictEqual(resEst, null);

    console.log("  ✓ PASS: db.js degrades gracefully without throwing when IDB is unavailable");
}

// 4. Simulated IndexedDB Mock for Storage & Pruning Verification
console.log("\n[TEST 4] Simulated IDB Cache & Pruning Verification...");
{
    // Minimal in-memory mock of IDB for testing
    const mockDbStore = new Map();

    const mockDb = {
        transaction: (stores, mode) => {
            return {
                objectStore: (storeName) => ({
                    get: (key) => {
                        const req = { onsuccess: null, onerror: null, result: mockDbStore.get(key) };
                        setTimeout(() => req.onsuccess && req.onsuccess({ target: req }), 0);
                        return req;
                    },
                    put: (record) => {
                        mockDbStore.set(record.key || record.courseName, record);
                        const req = { onsuccess: null, onerror: null };
                        setTimeout(() => req.onsuccess && req.onsuccess({ target: req }), 0);
                        return req;
                    },
                    delete: (key) => {
                        mockDbStore.delete(key);
                        const req = { onsuccess: null, onerror: null };
                        setTimeout(() => req.onsuccess && req.onsuccess({ target: req }), 0);
                        return req;
                    },
                    clear: () => {
                        mockDbStore.clear();
                    },
                    count: () => {
                        const req = { onsuccess: null, onerror: null, result: mockDbStore.size };
                        setTimeout(() => req.onsuccess && req.onsuccess({ target: req }), 0);
                        return req;
                    },
                    index: (indexName) => ({
                        openCursor: () => {
                            // Sort by lastAccessed ascending (oldest first)
                            const entries = Array.from(mockDbStore.values())
                                .sort((a, b) => (a[indexName] || 0) - (b[indexName] || 0));
                            let idx = 0;
                            const req = { onsuccess: null, onerror: null };
                            
                            function advance() {
                                if (idx < entries.length) {
                                    const curr = entries[idx];
                                    const cursor = {
                                        result: {
                                            value: curr,
                                            delete: () => {
                                                mockDbStore.delete(curr.key);
                                            },
                                            continue: () => {
                                                idx++;
                                                advance();
                                            }
                                        }
                                    };
                                    req.onsuccess && req.onsuccess({ target: cursor });
                                } else {
                                    req.onsuccess && req.onsuccess({ target: { result: null } });
                                }
                            }
                            setTimeout(advance, 0);
                            return req;
                        }
                    })
                }),
                oncomplete: null,
                onerror: null
            };
        }
    };

    // Populate mock store with 10 entries having varying timestamps
    for (let i = 1; i <= 10; i++) {
        mockDbStore.set(`key_${i}`, {
            key: `key_${i}`,
            svg: `<svg>${i}</svg>`,
            lastAccessed: 1000 + i * 10
        });
    }
    assert.strictEqual(mockDbStore.size, 10);

    // Prune if maxEntries is 7 (pruning 20% of 7 = 1 item)
    const deletedCount = await db.checkAndPruneCache(mockDb, 7, 0.4); // prune 40% of 7 = 2 items
    assert.strictEqual(deletedCount, 2, "Should delete exactly 2 oldest items");
    assert.strictEqual(mockDbStore.size, 8);
    assert.strictEqual(mockDbStore.has("key_1"), false, "Oldest key_1 must be deleted");
    assert.strictEqual(mockDbStore.has("key_2"), false, "Second oldest key_2 must be deleted");
    assert.strictEqual(mockDbStore.has("key_10"), true, "Newest key_10 must be retained");

    console.log("  ✓ PASS: IDB LRU pruning correctly targets oldest records based on lastAccessed");
}

console.log("\n=============================================================");
console.log("🎉 ALL LRU CACHE & STORAGE TESTS PASSED SUCCESSFULLY!");
console.log("=============================================================\n");
