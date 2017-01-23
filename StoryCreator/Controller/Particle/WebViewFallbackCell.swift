//
//  ParticleTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class WebViewFallbackCell: UITableViewCell, UIWebViewDelegate
{
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!

    let cardBackgroundBorder = CAShapeLayer()
    var particle:NewParticleObject!
    
    weak var delegate: WebViewFallbackCellProtocol?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        webView.delegate = self
    }

    deinit
    {
        webView.scrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            self.updatePageViewsFrames()
        }
    }

    func updatePageViewsFrames()
    {
        webView.sizeToFit()
        let newWebViewHeight:CGFloat = webView.scrollView.contentSize.height
        webViewHeight.constant = newWebViewHeight
        self.setNeedsUpdateConstraints()
        self.delegate?.reloadTable()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
       
        print(request.url?.query ?? "")
//        if request.URL?.query?.containsString("show_activity_indicator=true") {
//            
//        }
        return true
    }
    
    func setDetails(particle:NewParticleObject)
    {
        if self.particle != particle
        {
            self.particle = particle
            
            
            if let url = URL(string: particle.particleURL)
            {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        }
    }
    
    func getParticleData() -> String
    {
        return webView.stringByEvaluatingJavaScript(from: "getPbItem()")!
    }
}

@objc protocol WebViewFallbackCellProtocol: class
{
    func reloadTable()
}


