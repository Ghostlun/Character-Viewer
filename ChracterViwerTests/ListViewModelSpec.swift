import XCTest
@testable import simpsonsviewer

class ListViewModelSpec: XCTestCase {
    
    var subject: ListViewModel!
    var mockDelegate: MockListViewModel!
    var testUser: DataResponse!
    
    override func setUp() {
        mockDelegate = MockListViewModel()
        subject = ListViewModel(delegate: mockDelegate)
        testUser = DataResponse(relatedTopics: [Topic(firstUrl: "firstUrl", text: "testName - testUserName", icon: Icon(imgUrl: "testImageUrl"))])
        subject.dataSource = testUser.relatedTopics
        
        super.setUp()
    }
    
    func testNumberOfRowInSection() {
        XCTAssertEqual(subject.numberOfRowInSection(), 1)
    }
    
    func testGetSimsonData() {
        XCTAssertEqual(subject.getTopic(index: 0), testUser.relatedTopics[0])
    }
    
    func testGetSimpsonTitle() {
        XCTAssertEqual(subject.getTitle(index: 0), "testName")
    }
    
    func testHandleSearch() {
        subject.handleSearch(text: "test")
        XCTAssertEqual(subject.numberOfRowInSection(), 1)
    }
    
    func testFetchSchoolInformation() {
        subject.fetchInformation(url: ""){ (completion: String) in }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.mockDelegate.showLoaderCalled, true)
            XCTAssertEqual(self.mockDelegate.reloadDataCalled, true)
            XCTAssertEqual(self.mockDelegate.hideLoaderCalled, true)
        }
    }
    
    
}
