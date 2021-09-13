//
//  PlaylistsViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistsViewController: UIViewController {
    // MARK: Data -
    var user: UserModel?
    var playlists = [PlaylistModel]() {
        didSet {
            self.playlistsTableView.reloadData()
        }
    }
    
    // MARK: UI vars -
    var playlistsTableView = UITableView()
    
    // MARK: VC Lifycycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userId = user?.userId, let username = user?.username {
            self.title = username
            YandexApiCaller.getPlaylists(by: userId) { playlistResponseModel in
                DispatchQueue.main.async {
                    self.playlists = PlaylistModel.getPlaylists(from: playlistResponseModel)
                }
            }
            setUpPlaylistsTableView()
        } else {
            // messageErorr
        }
    }
    
    // MARK: SetUp functions -
    private func setUpPlaylistsTableView() {
        playlistsTableView.frame = view.safeAreaLayoutGuide.layoutFrame
        playlistsTableView.delegate = self
        playlistsTableView.dataSource = self
        playlistsTableView.register(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellReuseIdentifier: PlaylistTableViewCell.id)
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
//        let playlistCell = UITableViewCell()
        playlistCell.configureCell(by: playlists[indexPath.row])
        
        return playlistCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
