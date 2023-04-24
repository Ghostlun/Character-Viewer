enum AppError: Error {
    case badUrl
    case serverError
    case badResponse
    case noData
    case parsingFail
    case dataSourceMissing
    
    var descriptionErrorMessage: String {
        switch self {
        case .badUrl:
            return "This URL is not valid"
        case .serverError:
            return "Server has issue"
        case .badResponse:
            return "This is not valid response"
        case .noData:
            return "This is not valid response"
        case .parsingFail:
            return "There is parsing return"
        case .dataSourceMissing:
            return "Datasource is missing"
        }
    }
}
