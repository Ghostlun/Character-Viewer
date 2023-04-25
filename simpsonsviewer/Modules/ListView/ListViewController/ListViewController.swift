import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private lazy var viewModel = ListViewModel(delegate: self)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let simpsonInfo = sender as? Topic else { return }
        if (segue.identifier == "OpenDetails") {
            guard let vc = segue.destination as? DetailsViewController else { return }
            vc.inject(viewModel: DetailsViewModel(data: simpsonInfo))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: ListViewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListViewTableViewCell.reuseIdentifier)
        self.title = "Simpson Character List"
        self.loadData()
    }
    
    private func loadData() {
        viewModel.fetchInformation(url: Environment.baseURL) { _ in }
    }
}

extension ListViewController: ListViewModelDelegate {
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

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.handleSearch(text: searchText)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewTableViewCell.reuseIdentifier, for: indexPath) as? ListViewTableViewCell else { return UITableViewCell() }
        cell.populate(name: title)
        return cell
    }
}
