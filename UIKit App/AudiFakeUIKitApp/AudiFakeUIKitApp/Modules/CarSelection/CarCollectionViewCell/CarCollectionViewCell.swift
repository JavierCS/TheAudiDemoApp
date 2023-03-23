import UIKit

protocol CarCollectionViewCellProtocol: AnyObject {
    func getImageUrl() -> URL?
}

class CarCollectionViewCell: UICollectionViewCell {
    // MARK: - UIElements
    @IBOutlet weak var carImageView: UIImageView!
    
    // MARK: - Lifecycle Management
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - SetUp
    func drawDefaultImage(_ image: UIImage) {
        carImageView.contentMode = .center
        carImageView.setImage(image, animated: false)
    }
    
    func drawCarImage(_ image: UIImage, animated: Bool = true) {
        carImageView.contentMode = .scaleAspectFill
        carImageView.setImage(image, animated: animated)
        setNeedsLayout()
    }
}
