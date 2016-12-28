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
//    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    
    weak var delegate: ParticleTableViewCellProtocol?
    let cardBackgroundBorder = CAShapeLayer()
    var particle:NewParticleObject!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        webView.scrollView.isScrollEnabled = false
    }

    func setDetails(particle:NewParticleObject)
    {
        self.particle = particle
        
        if let particleImage = UIImage(named: particle.particleImage)
        {
//            self.iconImageView.image = particleImage
        }
        
        let url = URL(string: particle.particleURL)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    @IBAction func didPressDeleteCell(_ sender: Any)
    {
        self.delegate?.didPressDeleteCell(sender)
    }
}

@objc protocol ParticleTableViewCellProtocol {
    
    func didPressDeleteCell(_ sender: Any)
}
