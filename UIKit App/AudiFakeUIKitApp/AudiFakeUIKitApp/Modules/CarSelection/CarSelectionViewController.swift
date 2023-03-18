import UIKit

class CarSelectionViewController: UIViewController {
    // MARK: - UIElements
    @IBOutlet weak var carsCollection: UICollectionView!
    
    // MARK: - Logic Vars
    var cars: [AudiCarModel] = []
    
    // MARK: - Initialization Code
    static func fromNib() -> CarSelectionViewController {
        return CarSelectionViewController(nibName: String(describing: CarSelectionViewController.self), bundle: .main)
    }
    
    // MARK: - Lifecycle Management
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    // MARK: - View Configuration
    private func initialConfiguration() {
        title = "Elige un Audi"
        let carCellNib: UINib = UINib(nibName: String(describing: CarCollectionViewCell.self), bundle: Bundle(for: type(of: self)))
        carsCollection.register(carCellNib, forCellWithReuseIdentifier: String(describing: CarCollectionViewCell.self))
        carsCollection.dataSource = self
        carsCollection.delegate = self
        fetchCars()
    }
    
    func fetchCars() {
        guard let url = URL(string: "http://127.0.0.1:8080/audiAPI/carList") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
            guard let self = self,
                  let data = data,
                  let response = try? JSONDecoder().decode([AudiCarModel].self, from: data) else { return }
            DispatchQueue.main.async {
                self.printCars(response)
            }
        }
        task.resume()
    }
    
    func printCars(_ cars: [AudiCarModel]) {
        self.cars = cars
        carsCollection.reloadData()
    }
}

// MARK: - UICollectionViewDataSource Management
extension CarSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CarCollectionViewCell.self), for: indexPath) as? CarCollectionViewCell,
              let imageUrl = cars[indexPath.row].getImageUrl() else { return UICollectionViewCell() }
        AudiImageCacheManager.shared.fetchImage(locatedAt: imageUrl) { image, origin in
            guard let image = image else { return }
            cell.drawCarImage(image, animated: origin == .network)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Management
extension CarSelectionViewController: UICollectionViewDelegateFlowLayout {
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
