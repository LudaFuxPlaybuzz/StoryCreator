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
    
    var particle:Particle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDetails(particle:Particle)
    {
        self.particle = particle
        
        if let particleImage = UIImage(named: particle.image)
        {
            self.particleIcon.image = particleImage
        }
    
    }

}
