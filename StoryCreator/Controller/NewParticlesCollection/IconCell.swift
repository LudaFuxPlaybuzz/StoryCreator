//
//  NewParticleCollectionViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class IconCell  : UICollectionViewCell {
    
    @IBOutlet weak var particleIconButton: UIButton!
    
    weak var delegate: NewParticleCollectionViewCellProtocol?
    var particle:Particle!
    
    func setDetails(_ particle:Particle)
    {
        self.particle = particle
        
        if let particleImage = UIImage(named: particle.image)
        {
            self.particleIconButton.setBackgroundImage(particleImage, for: UIControlState.normal)
        }
    }
    
    @IBAction func didSelectNewParticle(_ sender: Any)
    {
        self.delegate?.didSelectNewParticle(particle: self.particle)
    }
}

@objc protocol NewParticleCollectionViewCellProtocol: class
{
    func didSelectNewParticle(particle:Particle)
}
