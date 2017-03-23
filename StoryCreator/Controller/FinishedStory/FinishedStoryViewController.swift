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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressDoneButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
