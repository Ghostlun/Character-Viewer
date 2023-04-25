import UIKit

class WireListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private lazy var viewModel = ListViewModel(delegate: self)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let topics = sender as? Topic else { return }
        if (segue.identifier == "OpenDetails") {
            guard let vc = segue.destination as? DetailsViewController else { return }
            vc.inject(viewModel: DetailsViewModel(data: topics))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: WireListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WireListTableViewCell.reuseIdentifier)
        self.loadData()
    }
    
    private func loadData() {
        viewModel.fetchInformation(url: Environment.baseURL) { _ in }
    }
}

extension WireListViewController: ListViewModelDelegate {
    func showLoader() {
        self.activityIndicatorView.startAnimating()
    }
    
    func hideLoader() {
        self.activityIndicatorView.stopAnimating()
    }
    
    func reloadData() {
        self.tableView?.reloadData()
    }
    
    func didFailWith(error: AppError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension WireListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.handleSearch(text: searchText)
    }
}

extension WireListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = viewModel.getTopic(index: indexPath.row)
        self.performSegue(withIdentifier: "OpenDetails", sender: data)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = viewModel.getTitle(index: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WireListTableViewCell.reuseIdentifier, for: indexPath) as? WireListTableViewCell else { return UITableViewCell() }
        cell.populate(name: title)
        return cell
    }
}
