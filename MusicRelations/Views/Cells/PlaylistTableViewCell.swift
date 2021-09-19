//
//  PlaylistTableViewCell.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    static let id = "PlaylistTableViewCellID"
    
    static let nib = UINib(nibName: "PlaylistTableViewCell", bundle: nil)
    
    private let loader = ImageLoader()
    
    var onReuse: () -> Void = {}
    
    @IBOutlet weak var playlistImage: UIImageView!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var amountOfTracksLabel: UILabel!
    @IBOutlet weak var tracksTextLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = Constants.UI.yandexColor
        backView.layer.cornerRadius = 10
        
        //playlistImage.image = UIImage(named: "likedAlbum")
        playlistImage.contentMode = .scaleToFill
        playlistImage.layer.borderWidth = 2
        playlistImage.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        
        

        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        playlistImage.image = UIImage(named: "squarePlaceholder")
    }
    
    func configureCell(by playlistModel: PlaylistModel) {
        playlistLabel.text = playlistModel.playlistName
        if let amount = playlistModel.trackAmount {
            amountOfTracksLabel.text = "\(amount)"
        } else {
            amountOfTracksLabel.isHidden = true
            tracksTextLabel.isHidden = true
        }
        if let imageUrl = playlistModel.playlistSquareImageUrl(with: 100), let url = URL(string: imageUrl) {
            let token = loader.loadImage(url) { result in
                do {
                    let image = try result.get()
                    DispatchQueue.main.async {
                        self.playlistImage.image = image
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
