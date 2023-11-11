//
//  AmslerViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 11.11.2023.
//

import UIKit
import SwiftUI

class AmslerViewController: UIViewController {

    
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 8
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Обычный режим", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(finishButton)
        view.backgroundColor = .white
        backgroundImageView.image = Asset.amslerTable
        finishButton.isHidden = true
        
        
        var timerView = TimerView(defaultTimeRemaining: 30, radius: 50)
        timerView.background(Color.white)
        timerView.onTimerFinish =  { [weak self] in
            self?.TimerDidFinish()
        }
        let hostingController = UIHostingController(rootView: timerView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Добавляем UIHostingController как дочерний контроллер
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        
        
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            backgroundImageView.heightAnchor.constraint(equalToConstant: view.frame.width)
        ])
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 20),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: hostingController.view.topAnchor, constant: 20),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            finishButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func TimerDidFinish() {
        print("TIMER FINISH")
        finishButton.isHidden = false
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Время вышло", message: "Показалось ли изображение искаженным?", preferredStyle: .alert)

       
               // Добавление кнопок
        let cancelAction = UIAlertAction(title: "Да", style: .default){ [weak self] _ in
            let contactAlertController = UIAlertController(title: "Вам следует обратиться к врачу!" , message: "Ранняя диагностика позволит вам снизить риски развития макулодистрофии", preferredStyle: .alert)
            let okAction2 = UIAlertAction(title: "OK", style: .cancel)
            contactAlertController.addAction(okAction2)
            self?.present(contactAlertController, animated: true, completion: nil)
        }
               let okAction = UIAlertAction(title: "Нет", style: .cancel)

               // Добавление кнопок к контроллеру
               alertController.addAction(cancelAction)
               alertController.addAction(okAction)

               // Показать alert контроллер
               present(alertController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
