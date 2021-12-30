//
//  ShowErrorMessage.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import UIKit

extension UIViewController {
    
    func present(errorMessage: String, onClose: @escaping () -> Void) {
        let errorAlertController = UIAlertController(title: "error.alert.title".localized(),
                                                     message: errorMessage,
                                                     preferredStyle: .alert)
        let okAction = UIAlertAction(title: "error.alert.close".localized(), style: .default) { _ in
            onClose()
        }
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
    }
    
}
