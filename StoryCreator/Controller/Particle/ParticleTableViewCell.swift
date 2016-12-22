//
//  ParticleTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class ParticleTableViewCell: UITableViewCell
{

    @IBOutlet weak var cardBackground: UIView!
    
    let cardBackgroundBorder = CAShapeLayer()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        cardBackgroundBorder.strokeColor = UIColor.init(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.25).cgColor
        cardBackgroundBorder.borderWidth = 3
        cardBackgroundBorder.fillColor = nil
        cardBackgroundBorder.lineDashPattern = [12, 8]
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        cardBackgroundBorder.path = UIBezierPath(rect: cardBackground.bounds).cgPath
        cardBackground.layer.addSublayer(cardBackgroundBorder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
