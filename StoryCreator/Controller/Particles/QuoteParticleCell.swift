//
//  QuoteParticleCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/21/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class QuoteParticleCell: UICollectionViewCell
{
    
    @IBOutlet weak var generatedQuote: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        let url = URL (string: "https://steelb.com/story.html?particle=quote")
        let requestObj = URLRequest(url: url! as URL)
        webView.loadRequest(requestObj)
    }
    
    @IBAction func didPressGenerate(_ sender: Any)
    {
        webView.isHidden = true
        generatedQuote.isHidden = false
    }
}
