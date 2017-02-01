//
//  PublishTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class PublishTableViewCell: UITableViewCell {

    @IBOutlet weak var publishButton: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        publishButton.layer.masksToBounds = true
        publishButton.layer.cornerRadius = 4
    }

    @IBAction func didPressCreateButton(_ sender: Any)
    {
        //        var storyContent = ""
        //
        //        for index in 0...newParticles.count
        //        {
        //            if let particleCell = particlesTable.cellForRow(at: IndexPath(row: index, section:0)) as? WebViewFallbackCell
        //            {
        //                storyContent += particleCell.getParticleData()
        //            }
        //        }
        //
        //        let alertController = UIAlertController(title: "Story Content", message:
        //            storyContent, preferredStyle: UIAlertControllerStyle.alert)
        //        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        //        
        //        self.present(alertController, animated: true, completion: nil)
    }
}
