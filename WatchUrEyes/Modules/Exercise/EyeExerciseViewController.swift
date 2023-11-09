//
//  FeedViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 01.06.2023.
//

import Foundation
import UIKit

class EyeExerciseViewController: UIViewController {
    
    var viewModel: ExerciseViewModelProtocol?

    fileprivate let data = [
        CustomData(title: "The Islands!", url: "maxcodes.io/enroll", backgroundImage: UIImage(named: "example")!),
        CustomData(title: "Subscribe to maxcodes boiiii!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "example")!),
        CustomData(title: "StoreKit Course!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "example")!),
        CustomData(title: "Collection Views!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "example")!),
        CustomData(title: "MapKit!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "example")!),
    ]
    
    let eyeStressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)

        //        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Снятие напряжения"
        return label
    }()
    
    fileprivate let basicCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(ExerciseCell.self, forCellWithReuseIdentifier: "cell")
            return cv
        }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        view.addSubview(basicCollectionView)
        view.addSubview(eyeStressLabel)
        basicCollectionView.showsHorizontalScrollIndicator = false
        basicCollectionView.delegate = self
        basicCollectionView.dataSource = self
        setUpConstraints()
    }
    
    func setUpConstraints() {
        eyeStressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        eyeStressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        eyeStressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        eyeStressLabel.heightAnchor.constraint(equalToConstant: 400).isActive = true

        basicCollectionView.topAnchor.constraint(equalTo: eyeStressLabel.bottomAnchor, constant: 5).isActive = true
        basicCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        basicCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        basicCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
    }
}

extension EyeExerciseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.3, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.goToDetail()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExerciseCell
        cell.data = self.data[indexPath.item]
        return cell
    }
}
