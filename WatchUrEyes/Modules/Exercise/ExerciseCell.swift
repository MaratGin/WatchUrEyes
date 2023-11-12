//
//  ExerciseCell.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 28.09.2023.
//

import Foundation
import UIKit

class ExerciseCell: UICollectionViewCell {
    
    var data1: TableMethod? {
        didSet {
            guard let data = data1 else { return }
            backgroundImageView.image = data.image
        }
    }
    var data2: CustomData? {
        didSet {
            guard let data = data2 else { return }
            backgroundImageView.image = data.backgroundImage
        }
    }
    
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.sizeToFit()
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .white
        return textView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 22, weight: .heavy)
//        label.text = "Chats AI"
        return label
    }()
    
    var blurView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.borderColor = UIColor.systemPink.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        return view
    }()
    
    // Создаем UIVisualEffectView и применяем к нему блюр
    
   
    
    
    func configureMethod(name: String, description: String, image: UIImage) {
        
        setupConstraints()
        backgroundImageView.image = image
        nameLabel.text = name
        descriptionTextView.text = description
        
        
        
    }
    
    func configureExercise(name: String, description: String, image: UIImage) {
        
        setupExerciseConstraints()
        backgroundImageView.image = image
        nameLabel.text = name
        descriptionTextView.text = description
        nameLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
    }
    func setupExerciseConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
        blurView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(blurView.snp.height)
        }
    }
    
    func setupBlur() {
        let blurEffect = UIBlurEffect(style: .light) // Вы можете изменить стиль блюра по вашему выбору
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = blurView.bounds
        
        // Задаем цвета градиента (от прозрачного до непрозрачного)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor]
        
        // Задаем местоположение цветов в градиенте (от прозрачного до непрозрачного)
        gradientLayer.locations = [0.0, 1.0]
        
        blurView.layer.addSublayer(gradientLayer)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurView.bounds
        blurView.addSubview(blurEffectView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(backgroundImageView)
//        contentView.addSubview(descriptionTextView)
//        contentView.addSubview(nameLabel)
        backgroundImageView.addSubview(blurView)
        blurView.addSubview(nameLabel)
//        blurView.addSubview(descriptionTextView)
        setupBlur()

        
        
//        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        backgroundImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//        backgroundImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
        blurView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(blurView.snp.height)
        }
//        descriptionTextView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(nameLabel.snp.bottom).offset(10)
//        }
    }
}

