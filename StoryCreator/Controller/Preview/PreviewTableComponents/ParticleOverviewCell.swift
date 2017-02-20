//
//  ParticleOverviewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/26/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class ParticleOverviewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    @IBOutlet weak var particleIcon: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    
    var particle:Particle!
    
//    @IBAction func didSwipeLeft(gesture:UIGestureRecognizer){
//        NSLog("Swipe left")
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        
//        let swipeLeft:UISwipeGestureRecognizer  = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(gesture:)))
//        swipeLeft.delegate = self
//        swipeLeft.numberOfTouchesRequired = 1
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//        
//        self.addGestureRecognizer(swipeLeft)
//    }
    
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
