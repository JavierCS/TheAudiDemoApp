import UIKit

class VersionSelectionViewController: MasterViewController {
    // MARK: - UIElements
    @IBOutlet weak var modelVersionsTableView: UITableView!
    
    var versions: [CarVersionTableViewCellProtocol] = []
    
    // MARK: - Initialization Code
    static func fromNib(using versions: [CarVersionTableViewCellProtocol]) -> VersionSelectionViewController {
        let controller = VersionSelectionViewController(nibName: String(describing: VersionSelectionViewController.self), bundle: .main)
        controller.versions = versions
        return controller
    }
    
    // MARK: - LifeCycle Management
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    // MARK: - Configuration Management
    private func initialConfiguration() {
        title = "Elige una versión"
        modelVersionsTableView.register(UINib(nibName: String(describing: CarVersionTableViewCell.self), bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: String(describing: CarVersionTableViewCell.self))
        modelVersionsTableView.separatorStyle = .none
        modelVersionsTableView.dataSource = self
        modelVersionsTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource Management
extension VersionSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        versions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarVersionTableViewCell.self), for: indexPath) as? CarVersionTableViewCell else { return UITableViewCell() }
        let version = versions[indexPath.row]
        cell.showData(version)
        if let url = version.getVersionImageUrl() {
            AudiImageCacheManager.shared.fetchImage(locatedAt: url) { image, origin in
                guard let image = image else { return }
                cell.showImage(image, animated: origin == .network)
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate Management
extension VersionSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
