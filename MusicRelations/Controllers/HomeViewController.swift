//
//  ViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 09.09.2021.
//

import UIKit
import DataManagerKit

class HomeViewController: UIViewController {
    
    // MARK: Outlets -
    @IBOutlet weak var addYandexIdButton: UIButton!
    
    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: data -
    private var users: [UserModel] = PlistHandler.getUsers() {
        didSet {
            PlistHandler.save(users)
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
        addYandexIdButton.addTarget(self, action: #selector(addYandexIdButtonDidTap), for: .touchUpInside)
    }
    
    func setUpUsersTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.tableFooterView = UIView()
        usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        usersTableView.isHidden = users.count == 0 ? true : false
    }
    
    // MARK: Actions -
    @objc
    func addYandexIdButtonDidTap () {
        addYandexIdAlert { newUserId in
            if !newUserId.isEmpty {         // add error handler
                YandexApiCaller.isUser(with: newUserId) { (isRightUserId, user) in
                    DispatchQueue.main.async {
                        if isRightUserId, let user = user {
                            if self.users.contains(where: { user in
                                user.userId == newUserId
                            }) {
                                self.errorAlert(message: "Такой ID уже используется")
                            } else {
                                self.users.append(user)
                            }
                        } else {
                            self.errorAlert(message: "Попробуйте ввести ID еще раз")
                        }
                    }
                }
            }
        }
    }
}

// MARK: UITableView extension -
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        userCell.setUpCell(for: users[indexPath.row])
        
        return userCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PlaylistsViewController()
        vc.user = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: Alerts -
extension HomeViewController {
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
    
    func errorAlert(message: String) {
        let alerController = UIAlertController(title: "Упс", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerController.addAction(okAction)
        
        present(alerController, animated: true, completion: nil)
    }
}
