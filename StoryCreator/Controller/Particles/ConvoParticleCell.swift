//
//  QuoteParticleCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/21/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class ConvoParticleCell: UICollectionViewCell
{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        let url = URL (string: "https://steelb.com/hack-convo.html?type=convo")
        let requestObj = URLRequest(url: url! as URL)
        webView.loadRequest(requestObj)
    }
}
