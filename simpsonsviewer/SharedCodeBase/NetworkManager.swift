import Foundation

class NetworkManager {

    static let manager = NetworkManager()

    private init() {}

    func fetch<T>(url: String, completion: @escaping (Result<T, AppError>) -> Void) where T: Decodable {

        guard let finalUrl = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }

        let request = NSMutableURLRequest(url: finalUrl,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            let completionOnMain: (Result<T, AppError>) -> Void = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            guard error == nil else {
                completionOnMain(.failure(.serverError))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completionOnMain(.failure(.badResponse))
                return
            }

            switch response.statusCode {
            case 200...299:
                guard let unwrappedData = data else {
                    completionOnMain(.failure(.noData))
                    return
                }
                do {
                    let object = try JSONDecoder().decode(T.self, from: unwrappedData)
                    completionOnMain(.success(object))
                } catch {
                    completionOnMain(.failure(.parsingFail))
                }

            default:
                completionOnMain(.failure(.badUrl))
            }
        }
        dataTask.resume()
    }
}
