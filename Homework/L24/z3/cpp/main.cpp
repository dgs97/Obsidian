#include "cpp-httplib/httplib.h"

int main() {
    httplib::Server svr;

    svr.Get("/", [](const httplib::Request &, httplib::Response &res) {
        res.set_content("Hello World from C++!", "text/plain");
    });

    std::cout << "Server started at http://localhost:8083" << std::endl;
    svr.listen("0.0.0.0", 8083);
    return 0;
}
