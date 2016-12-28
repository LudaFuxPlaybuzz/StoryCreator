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
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webViewContainerHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: ParticleTableViewCellProtocol?
    let cardBackgroundBorder = CAShapeLayer()
    var particle:NewParticleObject!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            self.updatePageViewsFrames()
        }
    }

    func updatePageViewsFrames()
    {
//        webView.sizeToFit()
//        let webViewContentHeight:CGFloat = webView.scrollView.contentSize.height
//        webView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: webViewContentHeight)
//        webViewContainerHeightConstraint.constant = webViewContentHeight
//        self.setNeedsUpdateConstraints()
    }
    
    deinit
    {
        webView.scrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func setDetails(particle:NewParticleObject)
    {
        self.particle = particle
        
        
        if let url = URL(string: particle.particleURL)
        {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
        else if let particleImage = UIImage(named: particle.particleImage)
        {
            self.iconImageView.image = particleImage
        }
    }
    
    @IBAction func didPressDeleteCell(_ sender: Any)
    {
        self.delegate?.didPressDeleteCell(sender)
    }
}

@objc protocol ParticleTableViewCellProtocol {
    
    func didPressDeleteCell(_ sender: Any)
}
