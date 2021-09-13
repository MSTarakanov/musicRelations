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
    
    static let id = "PlaylistTableViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
