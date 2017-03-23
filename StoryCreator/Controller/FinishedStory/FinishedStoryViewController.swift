//
//  FinishedStoryViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/23/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class FinishedStoryViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL (string: "https://www.playbuzz.com/playbuzz81/white-house-briefing-trump-intensifies-his-attacks-on-journalists-and-condemns-f-b-i-leakers?fromMobileApp=true")
        let requestObj = URLRequest(url: url! as URL)
        webView.loadRequest(requestObj)
    }
    
    @IBAction func didPressDoneButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
