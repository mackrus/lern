import http.server
import socketserver
import webbrowser
import os
import sys

PORT = 8000
DIRECTORY = "dist"


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)


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
