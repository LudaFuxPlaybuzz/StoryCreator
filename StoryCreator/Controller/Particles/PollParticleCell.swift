//
//  PollParticle.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/24/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class PollParticleCell: UICollectionViewCell
{
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        let url = URL (string: "https://www.playbuzz.com/playbuzz81/will-you-buy-katy-perrys-new-album-this-summer?fromMobileApp=true")
        let requestObj = URLRequest(url: url! as URL)
        webView.loadRequest(requestObj)
    }
}
