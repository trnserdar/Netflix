//
//  AlertManager.swift
//  Netflix
//
//  Created by SERDAR TURAN on 14.01.2021.
//

import UIKit

class AlertManager {
    
    func showAlert(title: String = TextConstants.errorTitle, message: String = TextConstants.errorMessage, alertAction: (() -> Void)?, viewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: TextConstants.ok, style: .default) { (action) in
            alertAction?()
        }
        alertController.addAction(action)
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
}
