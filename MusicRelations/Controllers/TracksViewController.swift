//
//  TracksControllerViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 20.09.2021.
//

import UIKit

class TracksViewController: UIViewController {

    static var playlistsTracksLoaded = [PlaylistModel: [TrackModel]]()

    var playlist: PlaylistModel?
    //private let tracks = [TrackModel]()
    private let tracks = Array(repeating: "track", count: 5)
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = Constants.UI.yandexColor
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    private let tracksCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.alpha = 0
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tracksCollectionView.delegate = self
        tracksCollectionView.dataSource = self
        tracksCollectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: TrackCollectionViewCell.id)
        view.addSubview(activityIndicator)
        view.addSubview(tracksCollectionView)
        if let playlist = playlist {
            YandexApiCaller.getTracks(from: playlist) { tr in
                print(tr)
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tracksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tracksCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tracksCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tracksCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tracksCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }

    
    

}

extension TracksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tracksCollectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionViewCell.id, for: indexPath) as! TrackCollectionViewCell
        print(indexPath)
        cell.configureCell(track: tracks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    
}
