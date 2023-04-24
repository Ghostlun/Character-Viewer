import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    private var viewModel: DetailsViewModelProtocol!
    
    func inject(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Name: \(viewModel.title)"
        imageView.downloadImage(with: viewModel.imageUrl)
        descriptionTextView.text = viewModel.text
    }
}
