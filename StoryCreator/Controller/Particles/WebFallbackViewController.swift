//
//  WebFallbackViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WebFallbackViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
//    @IBOutlet weak var webViewHeight: NSLayoutConstraint!

    var particle:Particle!
    
    weak var delegate: WebFallbackViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        loaderView.startAnimating()
//        webView.scrollView.isScrollEnabled = false
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        webView.delegate = self
        
//        self.title = particle.name
//        
//        if let url = URL(string: particle.url)
//        {
//            print(url)
//            let request = URLRequest(url: url)
//            webView.loadRequest(request)
//        }
        
        setNeedsStatusBarAppearanceUpdate()
    }

    deinit
    {
        webView.scrollView.removeObserver(self, forKeyPath: "contentSize")
        self.particle = nil
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
//        webViewHeight.constant = newWebViewHeight
        self.delegate?.reloadTable()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.url?.query ?? "")
        if (((request.url?.query) != nil) && request.url?.query == "GetImage") {
            self.delegate?.triggerOpenCamera()
        }
        //        if request.URL?.query?.containsString("show_activity_indicator=true") {
        //
        //        }
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loaderView.stopAnimating()
        loaderView.isHidden = true
    }
    func getParticleData() -> String
    {
        return webView.stringByEvaluatingJavaScript(from: "getPbItem()")!
    }

}

@objc protocol WebFallbackViewControllerProtocol: class
{
    func reloadTable()
    func triggerOpenCamera()
}
