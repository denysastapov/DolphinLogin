//
//  HeaderView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

import UIKit

class HeaderView: UIView {
    
    let headerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dolphin_bg"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 4
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let makeHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.shadowRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelText: String? {
        didSet {
            makeHeaderLabel.text = labelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHeaderView() {
        addSubview(headerImageView)
        addSubview(makeHeaderLabel)
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: self.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            makeHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            makeHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        makeHeaderLabel.alpha = 0.0
        makeHeaderLabel.transform = CGAffineTransform(translationX: -20.0, y: 0.0)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.makeHeaderLabel.alpha = 1.0
            self.makeHeaderLabel.transform = CGAffineTransform.identity
        })
    }
}

