import XCTest
@testable import simpsonsviewer

class ListViewModelSpec: XCTestCase {
    
    var subject: ListViewModel!
    var mockDelegate: MockListViewModel!
    var testUser: SimpsonResponse!
    
    override func setUp() {
        mockDelegate = MockListViewModel()
        subject = ListViewModel(delegate: mockDelegate)
        testUser = SimpsonResponse(simpsons: [SimpsonCharacter(firstUrl: "firstUrl", text: "testName - testUserName", icon: Icon(imgUrl: "testImageUrl"))])
        subject.dataSource = testUser.simpsons
        
        super.setUp()
    }
    
    func testNumberOfRowInSection() {
        XCTAssertEqual(subject.numberOfRowInSection(), 1)
    }
    
    func testGetSimsonData() {
        XCTAssertEqual(subject.getSimpsonData(index: 0), testUser.simpsons[0])
    }
    
    func testGetSimpsonTitle() {
        XCTAssertEqual(subject.getSimpsonTitle(index: 0), "testName")
    }
    
    func testHandleSearch() {
        subject.handleSearch(text: "test")
        XCTAssertEqual(subject.numberOfRowInSection(), 1)
    }
    
    func testFetchSchoolInformation() {
        subject.fetchSchoolInformation{ (completion: String) in }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.mockDelegate.showLoaderCalled, true)
            XCTAssertEqual(self.mockDelegate.reloadDataCalled, true)
            XCTAssertEqual(self.mockDelegate.hideLoaderCalled, true)
        }
    }
    
    
}
