import XCTest
@testable import DolphinHTTP

final class DolphinHTTPTests: XCTestCase {
    
    let mock = MockLoader()
    lazy var api: TestAPI = {
        return TestAPI(loader: mock)
    }()
    
    func testExample() {
        
        let responseJson = """
            [
                {
                  "age": 3,
                  "first_name": "Allen",
                  "last_name": "Lee",
                },
                {
                  "age": 5,
                  "first_name": "Will",
                  "last_name": "Cheng",
                }
            ]
        """
        
        let responseData = Data(responseJson.utf8)
        
        mock.then { (request, handler) in
            handler(.success(.init(request: request, response: HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "1.1", headerFields: nil)!, body: responseData)))
        }
        api.getTestUsers { users in
            XCTAssertEqual(users.count, 2)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
