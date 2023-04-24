import Foundation


struct SimpsonResponse: Codable {
    var simpsons: [SimpsonCharacter]
    
    enum CodingKeys: String, CodingKey {
        case simpsons = "RelatedTopics"
    }
}

struct SimpsonCharacter: Codable, Equatable {
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
