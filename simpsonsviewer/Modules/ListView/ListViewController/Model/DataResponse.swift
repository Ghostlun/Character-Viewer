import Foundation

struct DataResponse: Codable {
    var relatedTopics: [Topic]
    
    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
    }
}

struct Topic: Codable, Equatable {
    var firstUrl: String
    var text: String
    var icon: Icon
    
    enum CodingKeys: String, CodingKey {
        case firstUrl = "FirstURL"
        case text = "Text"
        case icon = "Icon"
    }
}

struct Icon: Codable, Equatable {
    var imgUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imgUrl = "URL"
    }
}
