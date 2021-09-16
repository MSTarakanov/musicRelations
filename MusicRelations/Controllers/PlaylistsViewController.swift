//
//  PlaylistsViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistsViewController: UIViewController {
    // MARK: Data -
    static var usersPlaylists = [UserModel:[PlaylistModel]]()
    
    var user: UserModel?
    private var playlists = [PlaylistModel]() {
        didSet {
            self.playlistsTableView.reloadData()
        }
    }
    
    // MARK: UI vars -
    private let playlistsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.alpha = 0
        return tableView
    }()
    
    private let tableViewActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = Constants.UI.yandexColor
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: VC Lifycycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableViewActivityIndicator)
        if let userId = user?.userId, let username = user?.username {
            self.title = username
            if let userUnwrapped = user, let playslistsFromCache = PlaylistsViewController.usersPlaylists[userUnwrapped] {
                playlists = playslistsFromCache
                playlistsTableView.alpha = 1
            } else {
                YandexApiCaller.getPlaylists(by: userId) { playlistResponseModel in
                    self.playlists = PlaylistModel.getPlaylists(from: playlistResponseModel)
                    PlaylistsViewController.usersPlaylists[self.user!] = self.playlists
                    DispatchQueue.main.async {
                        
                        UIView.animate(withDuration: 1) {
                            self.playlistsTableView.alpha = 1
                            self.tableViewActivityIndicator.alpha = 0
                        }
                    }
                }
            }
            
            setUpPlaylistsTableView()
        } else {
            // messageErorr
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewActivityIndicator.center = view.center

        playlistsTableView.translatesAutoresizingMaskIntoConstraints = false
        playlistsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        playlistsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        playlistsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        playlistsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

    }
    
    // MARK: SetUp functions -
    private func setUpPlaylistsTableView() {
        playlistsTableView.frame = view.safeAreaLayoutGuide.layoutFrame
        playlistsTableView.delegate = self
        playlistsTableView.dataSource = self
        playlistsTableView.register(PlaylistTableViewCell.nib, forCellReuseIdentifier: PlaylistTableViewCell.id)
        playlistsTableView.register(LikedAlbumHeader.self, forHeaderFooterViewReuseIdentifier: LikedAlbumHeader.id)
        self.playlistsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(playlistsTableView)
    }
}

// MARK: TableView extensions -

extension PlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playlistCell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.id, for: indexPath) as! PlaylistTableViewCell
        playlistCell.configureCell(by: playlists[indexPath.row])
        
        return playlistCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LikedAlbumHeader.id)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
