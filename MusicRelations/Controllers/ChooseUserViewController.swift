//
//  ViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 09.09.2021.
//

import UIKit
import DataManagerKit

class ChooseUserViewController: UIViewController {
    
    // MARK: Outlets -
    @IBOutlet weak var addYandexIdButton: UIButton!
    
    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: Data -
//    private var usersPlaylistsCache: [UserModel:PlaylistModel]?
    
    private var users: [UserModel] = PlistHandler.getUsers() {
        didSet {
            PlistHandler.save(users)
            changeView()
            usersTableView.reloadData()
        }
    }
    
    private func changeView() {
        if users.isEmpty {
            usersTableView.isHidden = true
            navigationController?.isNavigationBarHidden = true
        } else {
            usersTableView.isHidden = false
            navigationController?.isNavigationBarHidden = false
        }
    }
    
    // MARK: VC Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        title = "Выберите пользователя"
        
        setUpUsersTableView()
        setUpAddYandexButton()
    }
    
    
    // MARK: setUp functions -
    private func setUpAddYandexButton() {
        addYandexIdButton.addTarget(self, action: #selector(addYandexIdButtonDidTap), for: .touchUpInside)
    }
    
    private func setUpUsersTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.tableFooterView = UIView()
        usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.id)
        usersTableView.isHidden = users.isEmpty ? true : false
        navigationController?.isNavigationBarHidden = users.isEmpty ? true : false
    }
    
    // MARK: Actions -
    @objc
    private func addYandexIdButtonDidTap () {
        addYandexIdAlert { newUserId in
            if !newUserId.isEmpty {
                YandexApiCaller.getUser(with: newUserId) {  (user) in
                    DispatchQueue.main.async {
                        if let user = user {
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
extension ChooseUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.id, for: indexPath) as! UserTableViewCell
        
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
extension ChooseUserViewController {
    func addYandexIdAlert(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Почта: mstarakanov@yandex.ru", message: "ID: mstarakanov", preferredStyle: .alert)
        
        let actionAdd = UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            let textFromTextField = alertController.textFields?.first
            guard let text = textFromTextField?.text else {return}
            completion(text)
        })
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
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
