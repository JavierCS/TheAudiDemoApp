import UIKit

class CarSelectionViewController: UIViewController {
    // MARK: - UIElements
    @IBOutlet weak var carsCollection: UICollectionView!
    
    // MARK: - Logic Vars
    let carsImageCache = NSCache<NSString, UIImage>()
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
    
    func fetchCarImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] (data, urlResponse, error) in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.carsImageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
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
        if let carImage = carsImageCache.object(forKey: imageUrl.absoluteString as NSString) {
            cell.drawCarImage(carImage, animated: false)
        } else {
            fetchCarImage(url: imageUrl) { image in
                guard let image = image else { return }
                cell.drawCarImage(image)
            }
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
}
