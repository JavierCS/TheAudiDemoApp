import Foundation
import UIKit

extension UIImageView {
    func setImage(_ image: UIImage, animated: Bool = true, option: UIView.AnimationOptions = .transitionFlipFromLeft, completion: (() -> Void)? = nil) {
        let duration = animated ? 1.0 : 0.0
        UIView.transition(with: self, duration: duration, options: option, animations: {
            self.image = image
        }, completion: nil)
    }
}
