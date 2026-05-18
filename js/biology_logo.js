import { prepareWithSegments, layoutNextLineRange, materializeLineRange } from 'https://esm.sh/@chenglou/pretext';

export class BiologyLogo {
    constructor(element) {
        this.element = element;
        this.canvas = null;
        this.ctx = null;
        this.active = false;
        this.animationId = null;
        this.activeRoots = [];
        this.asciiGrid = [];
        this.gridCOLS = 0;
        this.gridROWS = 0;
        this.CELL_W = 10;
        this.CELL_H = 16;
        this.text = element.innerText;
        this.currentY = 0;
    }

    async start() {
        if (this.active) return;
        this.active = true;

        const style = window.getComputedStyle(this.element);
        const fontSize = parseFloat(style.fontSize);
        const font = style.font;
        const rect = this.element.getBoundingClientRect();
        const scrollY = window.scrollY;
        const scrollX = window.scrollX;

        this.element.style.visibility = 'visible';
        this.element.style.position = 'relative';

        this.CELL_H = fontSize * 0.8;
        this.CELL_W = this.CELL_H * 0.6;

        this.canvas = document.createElement('canvas');
        this.ctx = this.canvas.getContext('2d');
        
        this.ctx.font = font;
        const metrics = this.ctx.measureText(this.text);
        
        this.canvas.width = window.innerWidth;
        this.canvas.height = Math.max(document.documentElement.scrollHeight, 3000); 
        this.canvas.style.position = 'absolute';
        this.canvas.style.left = '0';
        this.canvas.style.top = (rect.top + scrollY) + 'px';
        this.canvas.style.pointerEvents = 'none';
        this.canvas.style.zIndex = '5';
        this.canvas.style.visibility = 'visible';
        this.canvas.style.opacity = '0.7';

        // Adjust for root spread
        this.canvas.style.left = '0';
        const canvasOffsetX = rect.left + scrollX;

        document.body.appendChild(this.canvas);

        this.gridCOLS = Math.floor(this.canvas.width / this.CELL_W);
        this.gridROWS = Math.floor(this.canvas.height / this.CELL_H);
        this.asciiGrid = Array(this.gridROWS).fill(null).map(() => Array(this.gridCOLS).fill(' '));

        this.currentY = fontSize;

        // Seed roots at each character position with high life for long growth
        for (let i = 0; i < this.text.length; i++) {
            if (Math.random() > 0.15) {
                this.activeRoots.push({
                    gridX: Math.floor((canvasOffsetX + i * metrics.width / this.text.length) / this.CELL_W),
                    gridY: Math.floor(this.currentY / this.CELL_H) + 1,
                    life: 400 + Math.random() * 600 // Very long life
                });
            }
        }

        this.animate();
    }

    updateRoots() {
        const newTips = [];
        for (const root of this.activeRoots) {
            if (root.life <= 0 || root.gridY >= this.gridROWS - 1) continue;

            const r = Math.random();
            let dx = 0;
            let char = '|';

            if (r < 0.20) { dx = -1; char = '/'; }
            else if (r < 0.40) { dx = 1; char = '\\'; }
            else if (r < 0.45) { dx = 0; char = 'Y'; }

            const nextX = Math.max(0, Math.min(this.gridCOLS - 1, root.gridX + dx));
            const nextY = root.gridY + 1;

            this.asciiGrid[nextY][nextX] = char;

            if (char === 'Y' && root.life > 20) {
                newTips.push({ gridX: nextX, gridY: nextY, life: root.life - 10 });
                newTips.push({ gridX: Math.max(0, nextX - 1), gridY: nextY, life: root.life - 10 });
            } else {
                newTips.push({ gridX: nextX, gridY: nextY, life: root.life - 1 });
            }
        }
        this.activeRoots = newTips;
    }

    animate() {
        if (!this.active) return;
        
        // Growth speed
        for(let i=0; i<3; i++) {
            this.updateRoots();
        }

        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        this.ctx.fillStyle = '#854d0e'; // Root brown
        this.ctx.font = `${this.CELL_H}px monospace`;

        const startRow = Math.floor(this.currentY / this.CELL_H) + 1;
        for (let y = startRow; y < this.gridROWS; y++) {
            for (let x = 0; x < this.gridCOLS; x++) {
                const char = this.asciiGrid[y][x];
                if (char !== ' ') {
                    this.ctx.fillText(char, x * this.CELL_W, y * this.CELL_H);
                }
            }
        }

        if (this.activeRoots.length > 0) {
            this.animationId = requestAnimationFrame(() => this.animate());
        }
    }

    stop() {
        this.active = false;
        if (this.animationId) cancelAnimationFrame(this.animationId);
        if (this.canvas && this.canvas.parentNode) {
            this.canvas.parentNode.removeChild(this.canvas);
        }
    }
}
