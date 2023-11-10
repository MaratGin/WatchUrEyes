//
//  ViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 02.06.2023.
//

import Foundation
import UIKit
import SnapKit

class CheckEyeController: UIViewController {
    
    fileprivate let data = [
        TableMethod(name: "Проверка по таблице Сивцева", description: "Some description to represent textView in it's work, so i'm writing very very long text", image: Asset.golovinTable!),
        TableMethod(name: "Проверка по таблице Головина", description: "Some description to represent textView in it's work, so i'm writing very very long text", image: Asset.sivcevTable!),
        TableMethod(name: "Проверка по таблице Амстера", description: "Some description to represent textView in it's work, so i'm writing very very long text", image: Asset.amslerTable!),
        TableMethod(name: "Avetistov", description: "Some description to represent textView in it's work, so i'm writing very very long text", image: Asset.golovinTable!),
    ]
    
    fileprivate let disclaimerData: [DisclaimerRoute] = [.sivcev, .golovin, .amsler, .amsler]
    
    
    fileprivate let methodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        
        cv.register(ExerciseCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
   var viewModel: CheckEyeViewModelProtocol?
   lazy var avetistovButton: UIButton = {
       var button = UIButton()
        
        button.setTitle("Проверка зрения методом Аветистова", for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.textColor = .white
        button.titleLabel?.numberOfLines = 0
        button.tintColor = .systemPink
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("CheckEyeController")
        avetistovButton.addTarget(self, action: #selector(moveToAvetisovMethod), for: .touchUpInside)
        view.backgroundColor = .black
        view.addSubview(methodCollectionView)
//        view.addSubview(avetistovButton)
//        view.bringSubviewToFront(avetistovButton)
        methodCollectionView.delegate = self
        methodCollectionView.dataSource = self
        setUpConstraints()
    }
    
    func setUpConstraints() {
        methodCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(view.frame.height).multipliedBy(0.25)
        }

        
        
        
        var constraints: [NSLayoutConstraint] = [avetistovButton.widthAnchor.constraint(equalToConstant: 200)
                                                 ,avetistovButton.heightAnchor.constraint(equalToConstant: 100)]
        if let superview = avetistovButton.superview {
            constraints.append(avetistovButton.centerXAnchor.constraint(equalTo: superview.centerXAnchor))
            constraints.append(avetistovButton.centerYAnchor.constraint(equalTo: superview.centerYAnchor))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func moveToAvetisovMethod() {
        viewModel?.goToAvetistovMethod()
    }
    
}

extension CheckEyeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("DELEGATE \(collectionView.frame.height)")
        return CGSize(width: collectionView.frame.width, height: view.frame.height * 0.25)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel?.showDisclaimer(name: disclaimerData[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExerciseCell
        cell.data1 = self.data[indexPath.item]
        cell.configureMethod(name: data[indexPath.row].name, description: data[indexPath.row].description, image: data[indexPath.row].image)
        
        return cell
    }
}
