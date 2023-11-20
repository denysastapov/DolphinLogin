//
//  UserInfoView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 19.11.2023.
//

import UIKit

class UserInfoViewController: UIViewController {

    private let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userGenderLabel = ControlsFactory.makeLabel(forText: "")
    private let userEmailLabel = ControlsFactory.makeLabel(forText: "")
    
    private var user: UserResponseProtocol
    
    init(user: UserResponseProtocol) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        setUpUserInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUserInfo() {
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        
        if let imageUrl = URL(string: user.image) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                guard let self = self else { return }

                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.userImageView.image = image
                        self.userImageView.layer.borderWidth = 2.0
                        self.userImageView.layer.borderColor = UIColor.blue.cgColor
                        self.userImageView.layer.cornerRadius = 130
                        self.userImageView.clipsToBounds = true
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
        
        headerView.labelText = "\(user.firstName) \n\(user.lastName)"
        userEmailLabel.text = "Email: \(user.email)"
        userGenderLabel.text = "Gender: \(user.gender)"
        
        let stackViewUserLabels = UIStackView(arrangedSubviews: [
            userEmailLabel,
            userGenderLabel
        ])
        
        let stackViewUserInfo = UIStackView(arrangedSubviews: [
            userImageView,
            stackViewUserLabels
        ])
        
        view.addSubview(headerView)
        view.addSubview(stackViewUserLabels)
        view.addSubview(stackViewUserInfo)
        
        stackViewUserLabels.axis = .vertical
        stackViewUserLabels.spacing = 15
        stackViewUserLabels.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewUserInfo.axis = .horizontal
        stackViewUserInfo.spacing = 15
        stackViewUserInfo.alignment = .center
        stackViewUserInfo.distribution = .fillProportionally
        stackViewUserInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            stackViewUserInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewUserInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewUserInfo.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            
            stackViewUserLabels.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewUserLabels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewUserLabels.topAnchor.constraint(equalTo: stackViewUserInfo.bottomAnchor, constant: 30)
        ])
    }
}
