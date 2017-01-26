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
    let image: String
    let url: String
    let name: String
    
    init(image:String, name:String, url:String)
    {
        self.image = image
        self.url = url
        self.name = name
    }
    
    override var description: String {
        return "\(type(of: self)) name - \(self.name)"
    }
}
