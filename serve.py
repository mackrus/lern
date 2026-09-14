#!/usr/bin/env python3
import http.server
import os
import socketserver
import sys
import webbrowser

PORT = int(sys.argv[1]) if len(sys.argv) > 1 and sys.argv[1].isdigit() else int(os.environ.get("PORT", 8001))
DIRECTORY = "dist"


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        self.send_header("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "credentialless")
        super().end_headers()


class ReuseAddrTCPServer(socketserver.TCPServer):
    allow_reuse_address = True


def serve():
    # Ensure we are in the project root
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    if not os.path.exists(DIRECTORY):
        print(f"Error: {DIRECTORY} directory not found. Run ./build.sh first.")
        sys.exit(1)

    with ReuseAddrTCPServer(("", PORT), Handler) as httpd:
        url = f"http://localhost:{PORT}"
        print(f"Serving at {url}")

        # Open browser in a way that doesn't block the server
        webbrowser.open(url)

        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server...")
            httpd.shutdown()


if __name__ == "__main__":
    serve()
