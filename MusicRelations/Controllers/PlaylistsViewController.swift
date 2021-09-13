//
//  PlaylistsViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistsViewController: UIViewController {
    // MARK: Data -
    var userId: String = ""
    var playlists: PlaylistResponseModel?
    
    // MARK: UI vars -
    var playlistsTableView = UITableView()
    
    // MARK: VC Lifycycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userId
        YandexApiCaller.getPlaylists(by: userId)
        setUpPlaylistsTableView()
    }
    
    // MARK: SetUp functions -
    private func setUpPlaylistsTableView() {
        playlistsTableView.frame = view.safeAreaLayoutGuide.layoutFrame
        playlistsTableView.delegate = self
        playlistsTableView.dataSource = self
        view.addSubview(playlistsTableView)
    }
}

// MARK: TableView extensions -

extension PlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
