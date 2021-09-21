//
//  TrackCollectionViewCell.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 20.09.2021.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    static let id = "TrackCollectionViewCellID"
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let backView = UIView(frame: .zero)
        backView.layer.borderWidth = 3
        backView.layer.borderColor = Constants.UI.yandexColor.cgColor
        backView.layer.cornerRadius = 20
        backView.backgroundColor = Constants.UI.yandexColor
        selectedBackgroundView = backView
        contentView.addSubview(trackNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        trackNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        trackNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = Constants.UI.yandexColor.cgColor
        contentView.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    
    func configureCell(track: TrackModel) {
        trackNameLabel.text = track.trackName
    }
    
    
}
