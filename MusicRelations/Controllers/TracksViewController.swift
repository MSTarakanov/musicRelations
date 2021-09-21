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
    private var tracks = [TrackModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tracksCollectionView.reloadData()
            }
        }
    }
    
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
            if let tracks = TracksViewController.playlistsTracksLoaded[playlist] {
                self.tracks = tracks
                self.tracksCollectionView.alpha = 1
            } else {
                TrackModel.getTracks(from: playlist) { tracks in
                    TracksViewController.playlistsTracksLoaded[playlist] = tracks
                    self.tracks = tracks
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 1) {
                            self.tracksCollectionView.alpha = 1
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
        cell.configureCell(track: tracks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath)
    }
}
