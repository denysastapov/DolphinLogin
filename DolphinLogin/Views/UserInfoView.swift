//
//  UserInfoView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 19.11.2023.
//

import UIKit

class UserInfoView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let userGenderLabel = ControlsFactory.makeLabel(forText: "")
    let userEmailLabel = ControlsFactory.makeLabel(forText: "")
    
    init(user: UserResponseProtocol) {
        super.init(frame: .zero)
        setUpUserInfo(with: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUserInfo(with user: UserResponseProtocol) {
        
        if let imageUrl = URL(string: user.image) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.userImageView.image = image
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
        userEmailLabel.text = user.email
        userGenderLabel.text = user.gender
        
        headerView.labelText = "\(user.firstName) \(user.lastName)"
        
        let stackViewUserLabels = UIStackView(arrangedSubviews: [
            userEmailLabel,
            userGenderLabel
        ])
        
        let stackViewUserInfo = UIStackView(arrangedSubviews: [
            userImageView,
            stackViewUserLabels
        ])
        
        addSubview(headerView)
        addSubview(stackViewUserLabels)
        addSubview(stackViewUserInfo)
        
        stackViewUserLabels.axis = .vertical
        stackViewUserLabels.spacing = 15
        stackViewUserLabels.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewUserInfo.axis = .horizontal
        stackViewUserInfo.spacing = 15
        stackViewUserInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            stackViewUserInfo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackViewUserInfo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackViewUserInfo.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30)

        ])
    }
}
