//
//  ParticleOverviewTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/26/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class ParticleOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var particleIcon: UIImageView!
    
    var particle:NewParticleObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDetails(particle:NewParticleObject)
    {
        self.particle = particle
        
        if let particleImage = UIImage(named: particle.particleImage)
        {
            self.particleIcon.image = particleImage
        }
    
    }

}
