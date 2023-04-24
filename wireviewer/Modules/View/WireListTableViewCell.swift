import UIKit

class WireListTableViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func populate(name: String) {
        titleLabel.text = name
    }
}
