//
//  CarCollectionViewCell.swift
//  AudiFakeUIKitApp
//
//  Created by jcruzsa on 16/03/23.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

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
    func drawCar(_ car: CarCollectionViewCellProtocol) {
        guard let imageUrl = car.getImageUrl() else {
            return
        }
        if let carImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
            carImageView.image = carImage
        } else {
            let request = URLRequest(url: imageUrl)
            URLSession.shared.dataTask(with: request) { [weak self] (data, urlResponse, error) in
                guard let self = self,
                      let data = data,
                      let image = UIImage(data: data) else {
                    return
                }
                imageCache.setObject(image, forKey: imageUrl.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.carImageView.image = image
                }
            }.resume()
        }
    }
}
