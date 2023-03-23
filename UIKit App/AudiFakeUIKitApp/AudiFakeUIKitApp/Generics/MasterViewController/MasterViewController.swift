//
//  MasterViewController.swift
//  AudiFakeUIKitApp
//
//  Created by jcruzsa on 17/03/23.
//

import UIKit

class MasterViewController: UIViewController {
    func showError(messge: String) {
        let alert = UIAlertController(title: "Audi", message: messge, preferredStyle: .alert)
        present(alert, animated: true)
    }
}
