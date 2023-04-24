import XCTest
@testable import simpsonsviewer

class DetailsViewModelSpec: XCTestCase {
    
    var subject: DetailsViewModel!
    
    override func setUp() {
        subject = DetailsViewModel(data: Topic(firstUrl: "firstUrl", text: "text", icon: Icon(imgUrl: "imageUrl")))
        
        super.setUp()
    }
    
    func testComputedProperty() {
        XCTAssertEqual(subject.title, "text")
        XCTAssertEqual(subject.imageUrl, "firstUrlimageUrl")
        XCTAssertEqual(subject.text, "text")
    }
}
