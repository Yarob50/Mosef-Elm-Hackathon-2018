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
    @IBOutlet weak var statusView1: UIView!
    @IBOutlet weak var statusView2: UIView!
    @IBOutlet weak var statusSubView1: UIView!
    @IBOutlet weak var statusSubView2: UIView!
    @IBOutlet weak var statusSubView3: UIView!
    @IBOutlet weak var statusLabel1: UILabel!
    @IBOutlet weak var statusLabel2: UILabel!
    @IBOutlet weak var statusLabel3: UILabel!
    @IBOutlet weak var statusLabelDate1: UILabel!
    @IBOutlet weak var statusLabelDate2: UILabel!
    @IBOutlet weak var statusLabelDate3: UILabel!
    @IBOutlet weak var criticalitySlider: UISlider!
    
    var model: Post? {
        didSet {
            guard let model = model else { return }
            switch model.status {
            case 1:
                statusSubView1.isHidden = false
                statusSubView2.isHidden = true
                statusSubView3.isHidden = true
                statusLabel1.alpha = 1
                statusLabel2.alpha = 0
                statusLabel3.alpha = 0
                statusLabelDate1.alpha = 1
                statusLabelDate2.alpha = 0
                statusLabelDate3.alpha = 0
                statusView1.backgroundColor = .lightMain
                statusSubView2.backgroundColor = .lightMain
                statusView2.backgroundColor = .lightMain
                statusSubView3.backgroundColor = .lightMain
                statusLabelDate1.text = "\(model.lastUpdate!)"
            case 2:
                statusSubView1.isHidden = true
                statusSubView2.isHidden = false
                statusSubView3.isHidden = true
                statusLabel1.alpha = 0
                statusLabel2.alpha = 1
                statusLabel3.alpha = 0
                statusLabelDate1.alpha = 0
                statusLabelDate2.alpha = 1
                statusLabelDate3.alpha = 0
                statusView1.backgroundColor = .main
                statusSubView2.backgroundColor = .main
                statusView2.backgroundColor = .lightMain
                statusSubView3.backgroundColor = .lightMain
                statusLabelDate2.text = "\(model.lastUpdate!)"
            default:
                statusSubView1.isHidden = true
                statusSubView2.isHidden = true
                statusSubView3.isHidden = false
                statusLabel1.alpha = 0
                statusLabel2.alpha = 0
                statusLabel3.alpha = 1
                statusLabelDate1.alpha = 0
                statusLabelDate2.alpha = 0
                statusLabelDate3.alpha = 1
                statusView1.backgroundColor = .main
                statusSubView2.backgroundColor = .main
                statusView2.backgroundColor = .main
                statusSubView3.backgroundColor = .main
                statusLabelDate3.text = "\(model.lastUpdate!)"
            }
            switch model.criticality {
            case 1:
                criticalityLabel.textColor = Color.colors[1]
                criticalityLabel.text = "الخطورة: عادية"
                criticalitySlider.minimumTrackTintColor = Color.criticality[2]
                criticalitySlider.setValue(1, animated: false)
            case 2:
                criticalityLabel.textColor = Color.colors[2]
                criticalityLabel.text = "الخطورة: متوسطة"
                criticalitySlider.minimumTrackTintColor = Color.criticality[1]
                criticalitySlider.setValue(2, animated: false)
            default:
                criticalityLabel.textColor = Color.colors[0]
                criticalityLabel.text = "الخطورة: عالية"
                criticalitySlider.minimumTrackTintColor = Color.criticality[0]
                criticalitySlider.setValue(3, animated: false)
            }
            postImageView.loadImageWithUrl(url: model.imageUrl!)
            profileImageView.loadImageWithUrl(url: model.user!.imageUrl!)
            if let name = model.user?.fullName, name != "" {
                profileNameLabel.text = name
            }
            
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
