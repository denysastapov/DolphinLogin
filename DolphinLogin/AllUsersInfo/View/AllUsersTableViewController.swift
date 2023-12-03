//
//  AllUsersTableViewController.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 01.12.2023.
//

import UIKit

class AllUsersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.makeHeaderLabel.text = "Users"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var users: [User] = []
        
    init(users: [User]) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllUsers()
    }
    
    private func setUpAllUsers() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AllUsersCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! AllUsersCell
        let user = users[indexPath.row]
        cell.backgroundColor = .white
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        let userInfoViewController = UserInfoViewController(
            user: UserInfoViewController.UserInfo(
                firstName: selectedUser.firstName,
                lastName: selectedUser.lastName,
                image: selectedUser.image,
                email: selectedUser.email,
                gender: selectedUser.gender,
                age: String(selectedUser.age)
            )
        )
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}

