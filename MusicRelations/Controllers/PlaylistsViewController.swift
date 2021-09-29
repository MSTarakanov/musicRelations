//
//  PlaylistsViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistsViewController: UIViewController {
    // MARK: Data -
    static var usersPlaylistsLoaded = [UserModel:[PlaylistModel]]()
    
    var user: UserModel?
    
    private var playlists = [PlaylistModel]() {
        didSet {
            DispatchQueue.main.async {
                self.playlistsTableView.reloadData()
            }
        }
    }
    
    // MARK: UI -
    private let playlistsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.alpha = 0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let tableViewActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = Constants.UI.yandexColor
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Constants.UI.yandexColor
        return refreshControl
    }()
    
    // MARK: VC Lifycycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableViewActivityIndicator)
        
        if let userUnwrapped = user {
            title = userUnwrapped.username
            if let playslistsFromCache = PlaylistsViewController.usersPlaylistsLoaded[userUnwrapped] {
                playlists = playslistsFromCache
                playlistsTableView.alpha = 1
            } else {
                YandexApiCaller.getPlaylists(by: userUnwrapped.userId) { playlistResponseModel in
                    self.playlists = PlaylistModel.getPlaylists(from: playlistResponseModel)
                    PlaylistsViewController.usersPlaylistsLoaded[userUnwrapped] = self.playlists
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 1) {
                            self.playlistsTableView.alpha = 1
                            self.tableViewActivityIndicator.stopAnimating()
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
       
        playlistsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        playlistsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        playlistsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        playlistsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

    }
    
    // MARK: SetUp functions -
    private func setUpPlaylistsTableView() {
        playlistsTableView.delegate = self
        playlistsTableView.dataSource = self
        playlistsTableView.register(PlaylistTableViewCell.nib, forCellReuseIdentifier: PlaylistTableViewCell.id)
        playlistsTableView.register(LikedAlbumHeader.self, forHeaderFooterViewReuseIdentifier: LikedAlbumHeader.id)
        
        playlistsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        view.addSubview(playlistsTableView)
    }
    
    // MARK: Actions -
    @objc
    private func refreshTable() {
        
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
        let tracksVC = TracksViewController()
        tracksVC.playlist = playlists[indexPath.row]
        navigationController?.pushViewController(tracksVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LikedAlbumHeader.id) as! LikedAlbumHeader
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension PlaylistsViewController: LikedAlbumHeaderDelegate {
    func viewDidTap() {
        YandexApiCaller.getLikedTracks(by: user!) { op in
            print(op)
        }
    }
}
