//
//  ViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 09.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets -
    @IBOutlet weak var addYandexIdButton: UIButton!
    
    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: data -
    private var users = PlistHandler.getUsersIds() {
        didSet {
            changeView()
            usersTableView.reloadData()
        }
    }
    
    func changeView() {
        print(users.count)
        if users.count == 0 {
            self.usersTableView.isHidden = true
        } else {
            self.usersTableView.isHidden = false
        }
    }
    
    // MARK: VC Lifycycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        self.title = "Выберите пользователя"
        setUpUsersTableView()
        setUpAddYandexButton()
    }
    
    // MARK: setUp functions -
    func setUpAddYandexButton() {
        addYandexIdButton.sizeToFit()
        addYandexIdButton.addTarget(self, action: #selector(addYandexIdButtonDidTap), for: .touchUpInside)
    }
    
    func setUpUsersTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        usersTableView.isHidden = users.count == 0 ? true : false
    }
    
    // MARK: Actions -
    @objc
    func addYandexIdButtonDidTap () {
        addYandexIdAlert { newUserId in
            if !newUserId.isEmpty {         // add error handler
                if YandexApiCaller.isUser(with: newUserId) {
                    PlistHandler.add(newUserId)
                    self.users = PlistHandler.getUsersIds()
                } 
            }
        }
    }
    
    
}

// MARK: UITableViewDelegate + DataSource -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        userCell.setUpCell(for: users[indexPath.row])
        
        return userCell
    }
}

// MARK: Alerts -
extension ViewController {
    func addYandexIdAlert(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Почта: mstarakanov@yandex.ru", message: "ID: mstarakanov", preferredStyle: .alert)
        
        let actionAdd = UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            let textFromTextField = alertController.textFields?.first
            guard let text = textFromTextField?.text else {return}
            completion(text)
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { textField in
            textField.placeholder = "Введите yandex ID"
        }
        alertController.addAction(actionAdd)
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
