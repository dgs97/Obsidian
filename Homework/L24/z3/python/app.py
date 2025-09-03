from http.server import BaseHTTPRequestHandler, HTTPServer

class HelloWorld(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(b"Hello World from Python!")

if __name__ == "__main__":
    server = HTTPServer(('0.0.0.0', 8000), HelloWorld)
    server.serve_forever()
