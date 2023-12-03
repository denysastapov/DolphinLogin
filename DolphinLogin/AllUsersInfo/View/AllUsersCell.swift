//
//  AllUsersCell.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 01.12.2023.
//

import UIKit

class AllUsersCell: UITableViewCell {
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userImageView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 50),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with user: User) {
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        nameLabel.textColor = .gray
        if let url = URL(string: user.image) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.userImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}

