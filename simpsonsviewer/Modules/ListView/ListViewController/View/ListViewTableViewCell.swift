import UIKit

class ListViewTableViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet private weak var nameLabel: UILabel!

    func populate(name: String) {
        nameLabel.text = name
    }
}
