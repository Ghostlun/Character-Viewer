import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var title: String { get }
    var imageUrl: String { get }
    var text: String { get }
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    private var data: Topic
    
    init(data: Topic) {
        self.data = data
    }
    
    var title: String {
        let titleComponents = data.text.components(separatedBy: " - ")
        return titleComponents[0]
    }
    
    var imageUrl: String {
        return "https://duckduckgo.com" + data.icon.imgUrl
    }
    
    var text: String {
        data.text
    }
}
