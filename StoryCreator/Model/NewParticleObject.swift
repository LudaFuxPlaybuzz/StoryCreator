//
//  NewParticleObject.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class NewParticleObject: NSObject
{
    let particleImage: String
    let particleURL: String
    
    init(particleImage:String, particleURL:String)
    {
        self.particleImage = particleImage
        self.particleURL = particleURL
    }
    
    override var description: String {
        return "\(type(of: self)) particleImage - \(self.particleImage)"
    }
}
