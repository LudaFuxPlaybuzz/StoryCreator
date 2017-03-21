//
//  CheckInDetails.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/21/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class CheckInDetails: NSObject
{
    let checkInTitle: String
    let iconName: String
    let details: String
    let mapImageName: String
    
    init(checkInTitle:String, iconName:String, details:String, mapImageName: String)
    {
        self.checkInTitle = checkInTitle
        self.iconName = iconName
        self.details = details
        self.mapImageName = mapImageName
    }
}
