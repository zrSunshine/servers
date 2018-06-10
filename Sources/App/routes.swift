import Vapor

struct LoginRequest: Content {
    var email: String
    var password: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    router.post("login") { req -> Future<HTTPStatus> in
        return try req.content.decode(LoginRequest.self).map(to: HTTPStatus.self, { (loginRequest) -> HTTPStatus in
            print(loginRequest.email)
            print(loginRequest.password)
            return HTTPStatus.ok
        })
    }
    
//    router.post("loginToo") { req -> Future<HTTPStatus> in
//        return try req.content.decode(LoginRequest.self).map(to: HTTPStatus.self) { loginRequest in
//            print(loginRequest.email)
//            print(loginRequest.password)
//            return HTTPStatus.ok
//        }
//    }
    
    /// Assume we get a future string back from some API
    var futureString: Future<String>?
    
    /// Assume we have created an HTTP client
    var client: Client?
    
//    /// Transform the string to a url, then to a response
//    let futureResponse = futureString?.map(to: URL.self) { string in
//        guard let url = URL(string: string) else {
//            throw Abort(.badRequest, reason: "Invalid URL string: \(string)")
//        }
//        return url
//        }.flatMap(to: Response.self) { url in
//            return client!.get(url)
//    }
//
//    print(futureResponse) // Future<Response>

    
    /// Transform the string to a url, then to a response
    let futureResponse = futureString?.map(to: URL.self) { string in
        guard let url = URL(string: string) else {
            throw Abort(.badRequest, reason: "Invalid URL string: \(string)")
        }
        return url
        }.flatMap(to: Response.self) { url in
            return client!.get(url)
    }
    
    print(futureResponse) // Future<Response>
}
