//
//  ListCell.swift
//  xcoders
//
//  Created by Ammar AlTahhan on 06/04/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var criticalityLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusSubView1: UIView!
    @IBOutlet weak var statusSubView2: UIView!
    @IBOutlet weak var statusSubView3: UIView!
    @IBOutlet weak var statusLabel1: UILabel!
    @IBOutlet weak var statusLabel2: UILabel!
    @IBOutlet weak var statusLabel3: UILabel!
    
    var model: Post?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let model = model {
            switch model.criticality {
            case 1:
                statusSubView1.isHidden = false
                statusSubView2.isHidden = true
                statusSubView3.isHidden = true
                statusLabel1.isHidden = false
                statusLabel2.isHidden = true
                statusLabel3.isHidden = true
            case 2:
                statusSubView1.isHidden = true
                statusSubView2.isHidden = false
                statusSubView3.isHidden = true
                statusLabel1.isHidden = true
                statusLabel2.isHidden = false
                statusLabel3.isHidden = true
            default:
                statusSubView1.isHidden = true
                statusSubView2.isHidden = true
                statusSubView3.isHidden = false
                statusLabel1.isHidden = true
                statusLabel2.isHidden = true
                statusLabel3.isHidden = false
            }
            postImageView.image = model.image
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
