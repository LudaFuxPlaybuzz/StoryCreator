//
//  ImageParticleCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/19/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class ImageParticleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var handPressIcon: UIImageView!
    
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)) as UIVisualEffectView
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        if (NSClassFromString("UIVisualEffectView") != nil) {
            // Con blur view
            blurView.frame = imageView.bounds
            blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            imageView.insertSubview(blurView, at: 0)
        }
        self.blurView.alpha = 0.0
        self.handPressIcon.alpha = 0.0
    }
    
    func blurImage()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.blurView.alpha = 1.0
            self.handPressIcon.alpha = 1.0
        })
    }
    
    @IBAction func revielImage(_ sender: Any)
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.blurView.alpha = 0.0
            self.handPressIcon.alpha = 0.0
        })
    }
}
