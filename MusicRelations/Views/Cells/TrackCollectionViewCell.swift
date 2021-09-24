//
//  TrackCollectionViewCell.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 20.09.2021.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    static let id = "TrackCollectionViewCellID"
    
    private let loader = ImageLoader()
    private var onReuse: () -> () = {}
    
    override var isSelected: Bool {
        didSet {
            changeAppearance()
        }
    }
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let artistsLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.backgroundColor = .systemGreen
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "squarePlaceholder")
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return imageView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
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
        contentView.addSubview(genreLabel)
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
        
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15
        ).isActive = true
        genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        genreLabel.text = nil
    }
    
    func changeAppearance() {
        labelsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = !isSelected
        labelsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: labelsStackView.bounds.height/2 + 10).isActive = isSelected
        trackNameLabel.numberOfLines = isSelected ? 3 : 1
        artistsLabel.numberOfLines = isSelected ? 3 : 1
        
        genreLabel.isHidden = !isSelected
        trackNameLabel.textColor = isSelected ? .white : .black
        artistsLabel.textColor = isSelected ? #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = isSelected
        
    }
    
    
    func configureCell(track: TrackModel) {
//        print("me")
        changeAppearance()
        trackNameLabel.text = track.trackName
        artistsLabel.text = track.artists.reduce("", {$0 == "" ? $0 + $1 : $0 + ", " + $1})
        if let UnwGenre = track.genre {
            genreLabel.text = "Genre: " + UnwGenre
        }
        if let url = URL(string: track.imageUrlWithSize200) {
            let token = loader.loadImage(url) { result in
                do {
                    let image = try result.get()
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } catch {
                    print(error)
                }
                self.onReuse = {
                    if let token = token {
                        self.loader.cancelLoad(token)
                    }
                }
            }
        }
    }
}
