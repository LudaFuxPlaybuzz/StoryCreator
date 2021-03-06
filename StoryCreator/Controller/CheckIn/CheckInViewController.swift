//
//  CheckInViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/21/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

@objc protocol CheckInViewControllerDelegate: class
{
    func didCheckIn(_ checkInDetails:CheckInDetails)
}

class CheckInViewController: UIViewController {

    var checkInItems = [CheckInDetails]()
    
    weak var delegate: CheckInViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        checkInItems = [CheckInDetails(checkInTitle: "Sarona TLV", iconName: "food", details: "0.3 mi · 115,345 check-ins", mapImageName: "sarona"),
        CheckInDetails(checkInTitle: "Ramat Gan Stadium", iconName: "ticket", details: "0.3 mi · 115,345 check-ins", mapImageName: "sarona"),
        CheckInDetails(checkInTitle: "The White House", iconName: "marker", details: "Ramat Gan · 6,037 check", mapImageName: "ramatGan"),
        CheckInDetails(checkInTitle: "London Stadium", iconName: "ticket", details: "Olimpic Park, Stanford, London, United Kindom", mapImageName: "london")]
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CheckInTableViewCell.self), for: indexPath) as! CheckInTableViewCell
        
        let checkInDetails = checkInItems[indexPath.row]
        
        cell.titleLabel.text = checkInDetails.checkInTitle
        cell.descriptionLabel.text = checkInDetails.details
        cell.iconImageView.image = UIImage.init(named: checkInDetails.iconName)
        
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        let checkInDetails = checkInItems[indexPath.row]
        self.delegate?.didCheckIn(checkInDetails)
        self.dismiss(animated: true, completion: nil)
    }
}
