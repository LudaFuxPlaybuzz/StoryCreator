//
//  NewParticleCollectionViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class NewParticleCell  : UICollectionViewCell {
    
    @IBOutlet weak var particleIconButton: UIButton!
    
    weak var delegate: NewParticleCellProtocol?
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

@objc protocol NewParticleCellProtocol: class
{
    func particleAdded(_ particle:Particle)
}
