//
//  LikedAlbumHeader.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 14.09.2021.
//

import UIKit

class LikedAlbumHeader: UITableViewHeaderFooterView {

    static var id = "LikedAlbumHeader"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "likedAlbum")
        return imageView
    }()
    
    private let albumLabel: UILabel = {
        let albumLabel = UILabel()
        albumLabel.text = "Мне нравится"
        albumLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        albumLabel.textColor = Constants.UI.yandexColor
        albumLabel.textAlignment = .center
        return albumLabel
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(albumLabel)
        contentView.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
}
