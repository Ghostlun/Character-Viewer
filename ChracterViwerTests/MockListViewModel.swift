import Foundation
@testable import simpsonsviewer

class MockListViewModel: ListViewModelDelegate {
    
    var showLoaderCalled: Bool = false
    func showLoader() {
        showLoaderCalled = true
    }
    
    var hideLoaderCalled: Bool = false
    func hideLoader() {
        hideLoaderCalled = true
    }
    
    var reloadDataCalled: Bool = false
    func reloadData() {
        reloadDataCalled = true
    }
    
    var expectedAppError: AppError = .serverError
    func didFailWith(error: AppError) {
        expectedAppError = error
    }
}
