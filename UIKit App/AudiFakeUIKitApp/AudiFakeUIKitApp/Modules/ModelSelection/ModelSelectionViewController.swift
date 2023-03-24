import UIKit

class ModelSelectionViewController: MasterViewController {
    // MARK: - UIElements
    @IBOutlet weak var modelsCollection: UICollectionView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Logic Vars
    var cars: [AudiCarModel] = []
    
    // MARK: - Initialization Code
    static func fromNib() -> ModelSelectionViewController {
        return ModelSelectionViewController(nibName: String(describing: ModelSelectionViewController.self), bundle: .main)
    }
    
    // MARK: - Lifecycle Management
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    // MARK: - View Configuration
    private func initialConfiguration() {
        title = "Elige un Audi"
        refreshControl.addTarget(self, action: #selector(fetchCars), for: .valueChanged)
        let modelCellNib: UINib = UINib(nibName: String(describing: ModelCollectionViewCell.self), bundle: .main)
        modelsCollection.register(modelCellNib, forCellWithReuseIdentifier: String(describing: ModelCollectionViewCell.self))
        modelsCollection.dataSource = self
        modelsCollection.delegate = self
        modelsCollection.addSubview(refreshControl)
        fetchCars()
    }
    
    @objc func fetchCars() {
        modelsCollection.refreshControl?.beginRefreshing()
        guard let url = URL(string: "http://127.0.0.1:8080/audiAPI/carList") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
            guard let self = self,
                  let data = data,
                  let response = try? JSONDecoder().decode([AudiCarModel].self, from: data) else {
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    self?.showError(messge: "Hubo un error al cargar la información, intenta de nuevo más tarde")
                }
                return
            }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.printCars(response)
            }
        }
        task.resume()
    }
    
    func printCars(_ cars: [AudiCarModel]) {
        self.cars = cars
        modelsCollection.reloadData()
    }
}

// MARK: - UICollectionViewDataSource Management
extension ModelSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ModelCollectionViewCell.self), for: indexPath) as? ModelCollectionViewCell else { return UICollectionViewCell() }
        guard let imageUrl = cars[indexPath.row].getImageUrl() else { return cell }
        if let cacheImage = AudiImageCacheManager.shared.image(locatedAt: imageUrl) {
            cell.drawCarImage(cacheImage, animated: false)
        } else if let holderImage = UIImage(named: "AudiLogo") {
            cell.drawDefaultImage(holderImage)
            AudiImageCacheManager.shared.fetchImage(locatedAt: imageUrl) { image, origin in
                guard let image = image else { return }
                cell.drawCarImage(image, animated: true)
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Management
extension ModelSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightWidthConstant = collectionView.frame.width / 2
        return CGSize(width: heightWidthConstant, height: heightWidthConstant)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCarVersions = cars[indexPath.row].versions else { return }
        let versionSelection = VersionSelectionViewController.fromNib(using: selectedCarVersions)
        show(versionSelection, sender: nil)
    }

}
