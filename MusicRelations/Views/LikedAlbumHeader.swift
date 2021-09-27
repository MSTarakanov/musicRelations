//
//  LikedAlbumHeader.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 14.09.2021.
//

import UIKit

class LikedAlbumHeader: UITableViewHeaderFooterView {

    static var id = "LikedAlbumHeaderID"
    
    // MARK: UIViews -
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "likedAlbum")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return imageView
    }()
    
    private let albumLabel: UILabel = {
        let albumLabel = UILabel()
        albumLabel.text = "Избранные"
        albumLabel.textColor = .white
        albumLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        albumLabel.textAlignment = .center
        return albumLabel
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.backgroundColor = Constants.UI.yandexColor
        DesignUtils.styleViewCell(view: stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    // MARK: Initialisation -
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(albumLabel)
        contentView.addSubview(stackView)
        contentView.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle -
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive           = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive    = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive                 = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive       = true
        albumLabel.heightAnchor.constraint(equalToConstant: 20).isActive                                = true
        
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
