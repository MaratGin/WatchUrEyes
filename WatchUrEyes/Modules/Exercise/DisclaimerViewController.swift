//
//  DisclaimerViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 10.11.2023.
//

import UIKit

class DisclaimerViewController: UIViewController {
    
    var name: DisclaimerRoute = .sivcev
    
    
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let startDefaultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 8
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Обычный режим", for: .normal)
        return button
    }()
    
    let startExpressButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 8
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Экспресс режим", for: .normal)
        return button
    }()
    
    var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.sizeToFit()
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.textColor = .white
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.attributedText
        return textView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 26, weight: .heavy)
//        label.text = "Chats AI"
        return label
    }()
    var amslerGoodExampleImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue

        iv.image = Asset.amslerGood
        iv.layer.cornerRadius = 6
        return iv
    }()
    var amslerBadExampleImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .blue
        iv.clipsToBounds = true
        iv.image = Asset.amslerBad
        iv.layer.cornerRadius = 6
        return iv
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 16
//        view.roundCorners([.topLeft, .topRight], radius: 12)
        return view
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = .clear
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
  
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 200)
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.bringSubviewToFront(contentView)
        
        
        contentView.backgroundColor = .black
        setupConstraints()
        
        switch name {
        case .golovin:
            golovinDisclaimer()
        case .amsler:
            amslerDisclaimer()
        case .sivcev:
            sivcevDisclaimer()
        }
        
        startExpressButton.addTarget(self, action: #selector(startExpress), for: .touchUpInside)
        startDefaultButton.addTarget(self, action: #selector(startDefault), for: .touchUpInside)

        
        // Do any additional setup after loading the view.
    }
    
    @objc func startDefault() {
        
    }
    
    
    @objc func startExpress() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func sivcevDisclaimer() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(startDefaultButton)
        contentView.addSubview(startExpressButton)
        backgroundImageView.image = Asset.sivcevTable
        nameLabel.text = "Таблица Сивцева"
        descriptionTextView.text = TextAsset.sivcevDescription


//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 20
//        let attributes = [NSAttributedString.Key.paragraphStyle : style]
//        descriptionTextView.attributedText = NSAttributedString(string: TextAsset.sivcevDescription, attributes: attributes)
        sivcevConstraints()
        
    }
    
    func golovinDisclaimer() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(startDefaultButton)
        contentView.addSubview(startExpressButton)
        backgroundImageView.image = Asset.golovinTable
        nameLabel.text = "Таблица Головина"
        descriptionTextView.text = TextAsset.golovinDescription


//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 20
//        let attributes = [NSAttributedString.Key.paragraphStyle : style]
//        descriptionTextView.attributedText = NSAttributedString(string: TextAsset.sivcevDescription, attributes: attributes)
        sivcevConstraints()
        
    }
    
    func amslerDisclaimer() {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 600)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(startExpressButton)
        contentView.addSubview(amslerBadExampleImage)
        contentView.addSubview(amslerGoodExampleImage)
        amslerBadExampleImage.image = Asset.amslerBad
        amslerGoodExampleImage.image = Asset.amslerGood
        startExpressButton.setTitle("Начать проверку", for: .normal)
//        amslerBadExampleImage.image?.resizingMode = .stretch
        
        backgroundImageView.image = Asset.amslerTable
        nameLabel.text = "Таблица Амслера"
        descriptionTextView.text = TextAsset.amslerDescription


//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 20
//        let attributes = [NSAttributedString.Key.paragraphStyle : style]
//        descriptionTextView.attributedText = NSAttributedString(string: TextAsset.sivcevDescription, attributes: attributes)
        amslerConstraints()
    }
    
    func sivcevConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
//            make.bottom.equalTo(startDefaultButton.snp.top).inset(20)
            make.height.equalTo(450)
//            make.height.equalTo(700)
        }
        
        startDefaultButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().inset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(descriptionTextView.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(60)
        }
        startExpressButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(startDefaultButton.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(60)
        }
    }
    
    func amslerConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
//            make.bottom.equalTo(startDefaultButton.snp.top).inset(20)
            make.height.equalTo(480)
//            make.height.equalTo(700)
        }
        amslerBadExampleImage.snp.makeConstraints { make in
            
            make.height.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.top.equalTo(descriptionTextView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().inset(20)
        }
        amslerGoodExampleImage.snp.makeConstraints { make in
            
            make.height.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.top.equalTo(amslerBadExampleImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().inset(20)
        }
        
        startDefaultButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().inset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(amslerGoodExampleImage.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(60)
        }
    }
    
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.height.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
//            make.leading.trailing.equalToSuperview()
//            make.width.height.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalToSuperview().offset(150)
//            make.height.equalToSuperview()
            make.width.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
//        blurView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.5)
//        }
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(5)
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview()
//            make.height.equalTo(blurView.snp.height)
//        }
//        descriptionTextView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(nameLabel.snp.bottom).offset(10)
//        }
    }
    
}

public enum DisclaimerRoute {
    case amsler
    case golovin
    case sivcev
}

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
