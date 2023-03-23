import UIKit

class MasterViewController: UIViewController {
    func showError(messge: String) {
        let alert = UIAlertController(title: "Audi", message: messge, preferredStyle: .alert)
        present(alert, animated: true)
    }
}
