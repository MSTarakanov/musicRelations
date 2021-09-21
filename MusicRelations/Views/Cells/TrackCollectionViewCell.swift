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
    
    private let artistsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "squarePlaceholder")
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return imageView
    }()
    
    
    private let selectedBackView: UIView = {
        let backView = UIView(frame: .zero)
        backView.backgroundColor = Constants.UI.yandexColor
        return backView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        DesignUtils.styleViewCell(view: selectedBackView)
        DesignUtils.styleViewCell(view: contentView)
        selectedBackgroundView = selectedBackView
        DesignUtils.styleViewCell(view: contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(trackNameLabel)
        labelsStackView.addArrangedSubview(artistsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        labelsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    
    func configureCell(track: TrackModel) {
        trackNameLabel.text = track.trackName
        artistsLabel.text = track.artists.reduce("", {$0 == "" ? $0 + $1 : $0 + ", " + $1})
    }
    
    
}
