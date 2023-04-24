import Foundation

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension CellReusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
