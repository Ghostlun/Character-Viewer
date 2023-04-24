import Foundation

protocol ListViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadData()
    func didFailWith(error: AppError)
}

class ListViewModel {
    
    var dataSource: [Topic] = []
    private var searchedDataSource: [Topic] = []
    private var searchBarActive: Bool = false
    
    weak var delegate: ListViewModelDelegate?
    
    init(delegate: ListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func numberOfRowInSection() -> Int {
        return searchBarActive ? searchedDataSource.count : dataSource.count
    }
    
    func getTopic(index: Int) -> Topic {
        return searchBarActive ? searchedDataSource[index] : dataSource[index]
    }
    
    func fetchInformation(url: String, completion: @escaping (String) -> Void) {
        self.delegate?.showLoader()
        NetworkManager.manager.fetch(url: url) { [weak self](result: Result<DataResponse, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.dataSource = response.relatedTopics
                self.delegate?.reloadData()
            case .failure(let error):
                self.delegate?.didFailWith(error: error)
            }
            self.delegate?.hideLoader()
        }
    }
    
    func getTitle(index: Int) -> String {
        if !searchBarActive {
            let components = dataSource[index].text.components(separatedBy: " - ")
            return components[0]
        } else {
            let components = searchedDataSource[index].text.components(separatedBy: " - ")
            return components[0]
        }
    }
    
    
    func handleSearch(text: String) {
        if text.isEmpty {
            searchBarActive = false
        } else {
            searchBarActive = true
            let strippedString = text.trimmingCharacters(in: .whitespaces).lowercased()
            searchedDataSource = dataSource.filter({ item in
                return item.text.lowercased().contains(strippedString)
            })
        }
        self.delegate?.reloadData()
    }
}
