import Foundation
import UIKit

extension UIImageView {
    func setImage(_ image: UIImage, animated: Bool = true, completion: (() -> Void)? = nil) {
        let duration = animated ? 1.0 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionFlipFromLeft, animations: {
            self.image = image
        }, completion: nil)
    }
}
