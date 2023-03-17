//
//  CarVersionTableViewCell.swift
//  AudiFakeUIKitApp
//
//  Created by jcruzsa on 17/03/23.
//

import UIKit

protocol CarVersionTableViewCellProtocol {
    func getModelVersion() -> String?
    func getInitialPrice() -> String?
    func getVersionImageUrl() -> URL?
}

class CarVersionTableViewCell: UITableViewCell {
    // MARK: - UIElements
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var clippedView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var versionImageView: UIImageView!
    
    // MARK: - LifeCycle Management
    override func awakeFromNib() {
        super.awakeFromNib()
        initialConfiguration()
    }
    
    // MARK: - Configuration Management
    private func initialConfiguration() {
        selectionStyle = .none
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 0.5
        clippedView.layer.cornerRadius = 10
        clippedView.clipsToBounds = true
    }
    
    func showData(_ data: CarVersionTableViewCellProtocol) {
        versionLabel.text = data.getModelVersion()
        priceLabel.text = data.getInitialPrice()
    }
    
    func showImage(_ image: UIImage, animated: Bool) {
        versionImageView.setImage(image, animated: animated, option: .transitionCrossDissolve)
        setNeedsLayout()
    }
}
