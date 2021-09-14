//
//  PlaylistTableViewCell.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var playlistImage: UIImageView!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var amountOfTracksLabel: UILabel!
    @IBOutlet weak var tracksTextLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    static let id = "PlaylistTableViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = Constants.UI.yandexColor
        backView.layer.cornerRadius = 10
        
        playlistImage.image = UIImage(named: "likedAlbum")
        playlistImage.contentMode = .scaleToFill
        playlistImage.layer.borderWidth = 2
        playlistImage.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(by playlistModel: PlaylistModel) {
        playlistLabel.text = playlistModel.playlistName
        if let amount = playlistModel.trackAmount {
            amountOfTracksLabel.text = "\(amount)"
        } else {
            amountOfTracksLabel.isHidden = true
            tracksTextLabel.isHidden = true
        }
    }
    
    
}
