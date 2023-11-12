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
        TableMethod(name: "Упражнения для снятия напряжения", description: "", image: Asset.relax!),
        TableMethod(name: "Упражнения при близорукости", description: "", image: Asset.bliz!),
        TableMethod(name: "Упражнения при дальнозоркости", description: "", image: Asset.daln!)
    ]
    
    fileprivate let basicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ExerciseCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        view.addSubview(basicCollectionView)
        basicCollectionView.delegate = self
        basicCollectionView.dataSource = self
        setUpConstraints()
    }
    
    func setUpConstraints() {
        basicCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(view.frame.height).multipliedBy(0.25)
        }
    }
}

extension EyeExerciseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("DELEGATE \(collectionView.frame.height)")
        return CGSize(width: collectionView.frame.width, height: view.frame.height * 0.25)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            viewModel?.goToExercise(type: .relax)
        case 1:
            viewModel?.goToExercise(type: .bliz)
        case 2:
            viewModel?.goToExercise(type: .daln)
        default:
            viewModel?.goToExercise(type: .relax)

            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExerciseCell
        cell.data1 = self.data[indexPath.item]
        cell.configureExercise(name: data[indexPath.row].name, description: data[indexPath.row].description, image: data[indexPath.row].image)
        
        return cell
    }
}

public enum ExerciseMethod {
    case relax
    case bliz
    case daln
}
