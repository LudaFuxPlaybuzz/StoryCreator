//
//  Particle.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class Particle: NSObject
{
    var image = ""
    
    override init()
    {

    }
    
    init(image:String)
    {
        self.image = image
    }
    
    override var description: String {
        return "\(type(of: self)) image - \(self.image)"
    }
}
