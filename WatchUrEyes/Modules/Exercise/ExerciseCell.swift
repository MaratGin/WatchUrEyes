//
//  ExerciseCell.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 28.09.2023.
//

import Foundation
import UIKit

class ExerciseCell: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
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
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .white
        return textView
    }()
    
    var navigationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Allerta-Regular", size: 20)
        label.text = "Chats AI"
        return label
    }()
    
    
    func configureMethod(name: String, description: String, image: UIImage) {
        backgroundImageView.image = image
        descriptionTextView.text = description
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(backgroundImageView)
        
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
    }
}

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}
