import UIKit

class MasterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.sizeToFit()
        // Actualizar el título del navigation bar
//        self.navigationController?.navigationBar.setNeedsLayout()
//        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func showError(title: String = "Audi", messge: String, actionTitle: String = "Ok", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: messge, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        present(alert, animated: true)
    }
}
