//
//  CheckInViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/21/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {

    var checkInItems = [CheckInDetails]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        checkInItems = [CheckInDetails(checkInTitle: "Sarona TLV", iconName: "", details: "0.3 mi · 115,345 check-ins", mapImageName: ""),
        CheckInDetails(checkInTitle: "The White House", iconName: "", details: "1600 Pensylvania Avenue, Washington", mapImageName: ""),
        CheckInDetails(checkInTitle: "London Stadium", iconName: "", details: "Olimpic Park, Stanford, London, United Kindom", mapImageName: "")]
    }
    
    @IBAction func didPressCancelButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CheckInViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CheckInTableViewCell.self), for: indexPath) as! CheckInTableViewCell
        
        let checkInDetails = checkInItems[indexPath.row]
        
        cell.titleLabel.text = checkInDetails.checkInTitle
        cell.descriptionLabel.text = checkInDetails.details
        
        return cell

    }

}
