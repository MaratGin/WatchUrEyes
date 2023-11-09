//
//  EnterViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 02.06.2023.
//

import Foundation
import UIKit
import LocalAuthentication

class EnterViewController: UIViewController {
    
    var coordinator: EnterViewCoordinator?
    
    lazy var logInButton: UIButton = {
        var button = UIButton()
         button.setTitle("Войти", for: .normal)
         button.titleLabel?.font = UIFont(name: "Futura Medium", size: 26)
         button.titleLabel?.textColor = .white
         button.backgroundColor = .systemBlue
         button.layer.cornerRadius = 15.0
         button.translatesAutoresizingMaskIntoConstraints = false
         
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HERe")
        view.backgroundColor = .darkGray
        logInButton.addTarget(self, action: #selector(goToApp), for: .touchUpInside)
        view.addSubview(logInButton)
        view.bringSubviewToFront(logInButton)
        setUpConstraints()
    }
 
    func setUpConstraints() {
        
        var constraints: [NSLayoutConstraint] = [logInButton.widthAnchor.constraint(equalToConstant: 250)
                                                 ,logInButton.heightAnchor.constraint(equalToConstant: 80)]
        if let superview = logInButton.superview {
            constraints.append(logInButton.centerXAnchor.constraint(equalTo: superview.centerXAnchor))
            constraints.append(logInButton.centerYAnchor.constraint(equalTo: superview.centerYAnchor))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func goToApp() {
        let context = LAContext()
        var error: NSError? = nil
        let reason = "Please authorize with biometrics"
        
        /*
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                guard success, error == nil else {
                    let alert = UIAlertController(title: "Failed to authenficate", message: "Please, try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self?.present(alert, animated: true)
                    return
                }
                DispatchQueue.main.async {
                    print("EnterViewController moving to App")
                    self?.coordinator?.navigate(with: .moveToApp)
                }
            }
        } else {
            let alert = UIAlertController(title: "Unavailable", message: "You can't use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            // can not use
                }
        */
        coordinator?.navigate(with: .moveToApp)        
    }
}
