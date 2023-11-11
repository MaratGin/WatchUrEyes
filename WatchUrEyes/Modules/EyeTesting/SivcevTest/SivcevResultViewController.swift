//
//  ResultViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 11.11.2023.
//

import UIKit

class SivcevResultViewController: UIViewController {
    
    var userRightRow = 1
    var userLeftRow = 1

    var userDistance = 5.0
    var answer = 0.0
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        return label
    }()
    var descriptionTextView1: UITextView = {
        let textView = UITextView()
        textView.sizeToFit()
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.textColor = .white
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        return textView
    }()
    var descriptionTextView2: UITextView = {
        let textView = UITextView()
        textView.sizeToFit()
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        textView.textColor = .white
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        return textView
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
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 16
//        view.roundCorners([.topLeft, .topRight], radius: 12)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 200)
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.bringSubviewToFront(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionTextView1)
        setupConstraints()
        answer = calculateAnswer()
        nameLabel.text = "Ваша острота:  \(answer) "
        if userLeftRow >= 1 && userLeftRow <= 6 {
            descriptionTextView1.text = TextAsset.badVision
        }
        if userLeftRow >= 7 && userLeftRow <= 8 {
            descriptionTextView1.text = TextAsset.mediumVision
        }
        if userLeftRow >= 9 {
            descriptionTextView1.text = TextAsset.bestVision
        }
        
    }
    
    func calculateAnswer() -> Double{
        switch userLeftRow {
        case 1:
            return 0.1
        case 2:
            return 0.2

        case 3:
            return 0.3

        case 4:
            return 0.4

        case 5:
            return 0.5

        case 6:
            return 0.6

        case 7:
            return 0.7

        case 8:
            return 0.8

        case 9:
            return 0.9

        case 10:
            return 1.0

        case 11:
            return 1.5

        case 12:
            return 2.0
        default:
            return 2.0

        }
        
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
//            make.leading.trailing.equalToSuperview()
//            make.width.height.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalToSuperview()
//            make.height.equalToSuperview()
            make.width.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.75)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        descriptionTextView1.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.height.equalTo(400)
        }
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
