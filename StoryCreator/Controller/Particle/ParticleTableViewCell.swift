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
    @IBOutlet weak var iconImageView: UIImageView!
    
    let cardBackgroundBorder = CAShapeLayer()
    var particle:NewParticleObject!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        cardBackgroundBorder.path = UIBezierPath(rect: cardBackground.bounds).cgPath
        cardBackground.layer.addSublayer(cardBackgroundBorder)

        cardBackgroundBorder.strokeColor = UIColor.init(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.25).cgColor
        cardBackgroundBorder.borderWidth = 3
        cardBackgroundBorder.fillColor = nil
        cardBackgroundBorder.lineDashPattern = [12, 8]
    }

    func setDetails(particle:NewParticleObject)
    {
        self.particle = particle
        
        if let particleImage = UIImage(named: particle.particleImage)
        {
            self.iconImageView.image = particleImage
        }
    }
}
