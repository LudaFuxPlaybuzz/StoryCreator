//
//  ParticleOverviewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/26/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class ParticleOverviewCell: UITableViewCell {

    @IBOutlet weak var particleIcon: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    
    var particle:Particle!
    
    func setDetails(particle:Particle)
    {
        self.particle = particle
        
        self.explanationLabel.text = "Preview of \(particle.name)"
        
        if let particleImage = UIImage(named: particle.image)
        {
            self.particleIcon.image = particleImage
        }
    
    }

}
