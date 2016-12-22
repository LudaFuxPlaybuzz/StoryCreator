//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var particlesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.layer.masksToBounds = true
        createButton.layer.cornerRadius = 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NewParticlesCollectionTableViewCell.self), for: indexPath) 
            //        let entry = data.places[indexPath.row]
//        let image = UIImage(named: entry.filename)
//        cell.bkImageView.image = image
//        cell.headingLabel.text = entry.heading
        return cell
    }
}

