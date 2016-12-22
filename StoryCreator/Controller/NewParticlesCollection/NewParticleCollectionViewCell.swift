//
//  NewParticleCollectionViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class NewParticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var particleImage: UIImageView!
    
    var particle:NewParticleObject!
    
    func setDetails(_ particle:NewParticleObject)
    {
        self.particle = particle
        
        if let particleImage = UIImage(named: particle.particleImage)
        {
            self.particleImage.image = particleImage
        }
    }
}
