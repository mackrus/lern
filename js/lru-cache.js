/**
 * Lightweight, zero-dependency in-memory LRU Cache.
 * Follows Map interface (get, set, has, delete, clear, size, iterators).
 */
export class LruCache {
    constructor(maxSize = 100) {
        if (maxSize <= 0) throw new Error("maxSize must be > 0");
        this.maxSize = maxSize;
        this.map = new Map();
    }

    get size() {
        return this.map.size;
    }

    has(key) {
        return this.map.has(key);
    }

    get(key) {
        if (!this.map.has(key)) return undefined;
        // Refresh access order for LRU (re-insert at the end)
        const value = this.map.get(key);
        this.map.delete(key);
        this.map.set(key, value);
        return value;
    }

    set(key, value) {
        if (this.map.has(key)) {
            this.map.delete(key);
        } else if (this.map.size >= this.maxSize) {
            // Evict oldest (first item in Map iteration order)
            const oldestKey = this.map.keys().next().value;
            this.map.delete(oldestKey);
        }
        this.map.set(key, value);
        return this;
    }

    delete(key) {
        return this.map.delete(key);
    }

    clear() {
        this.map.clear();
    }

    keys() {
        return this.map.keys();
    }

    values() {
        return this.map.values();
    }

    entries() {
        return this.map.entries();
    }

    [Symbol.iterator]() {
        return this.map[Symbol.iterator]();
    }
}
