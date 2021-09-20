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
        contentView.addSubview(trackNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(track: String) {
        trackNameLabel.text = track
    }
    
    
}
