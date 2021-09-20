//
//  TrackCollectionViewCell.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 20.09.2021.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    static let id = "TrackCollectionViewCellID"
    
    private let buttonView: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 2
        btn.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(buttonView)
        buttonView.addSubview(trackNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true

        trackNameLabel.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(track: String) {
        trackNameLabel.text = track
    }
    
    
}
