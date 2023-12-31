//
//  UserInfoViewController.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 19.11.2023.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    struct UserInfo {
        let firstName: String
        let lastName: String
        let image: String
        let email: String
        let gender: String
        let age: String
    }
    
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
    private let userAgeLabel = ControlsFactory.makeLabel(forText: "")
    
    
    private var user: UserInfo
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
    }
    
    init(user: UserInfo) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        setUpUserInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUserInfo() {
        view.backgroundColor = .white
        
        if let imageUrl = URL(string: user.image) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                guard let self = self else { return }
                
                if let data = data, let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.userImageView.image = image
                        self.userImageView.layer.borderWidth = 2.0
                        self.userImageView.layer.borderColor = UIColor.blue.cgColor
                        self.userImageView.layer.cornerRadius = 50
                        self.userImageView.clipsToBounds = true
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                    DispatchQueue.main.async {
                        self.userImageView.image = UIImage(named: "default-profile")
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(named: "default-profile")
            }
        }
        
        headerView.labelText = "\(user.firstName) \n\(user.lastName)"
        userEmailLabel.text = "Email: \(user.email)"
        userGenderLabel.text = "Gender: \(user.gender)"
        userAgeLabel.text = "Age: \(user.age)"
        
        
        let stackViewUserLabels = UIStackView(arrangedSubviews: [
            userEmailLabel,
            userGenderLabel,
            userAgeLabel
        ])
        
        let stackViewUserInfo = UIStackView(arrangedSubviews: [
            userImageView,
            stackViewUserLabels
        ])
        
        view.addSubview(headerView)
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
            
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
