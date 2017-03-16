//
//  NewParticleCollectionViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit


@objc protocol ParticleIconCellDelegate: class
{
    func particleAdded(_ particle:Particle)
}

class ParticleIconCell  : UICollectionViewCell {
    
    @IBOutlet weak var particleIconButton: UIButton!
    
    weak var delegate: ParticleIconCellDelegate?
    var particle:Particle!
    
    func setDetails(_ particle:Particle)
    {
        self.particle = particle
        
        if let particleImage = UIImage(named: particle.image)
        {
            self.particleIconButton.setBackgroundImage(particleImage, for: UIControlState.normal)
        }
    }
    
    @IBAction func didPressAddParticle(_ sender: Any)
    {
        self.delegate?.particleAdded(self.particle)
    }
}

