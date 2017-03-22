//
//  FirebaseManager.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/13/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit
import Firebase

class FirebaseManager: NSObject
{
    func useFirebaseDatabase()
    {
        let ref = FIRDatabase.database().reference()
        ref.child("articles").child("article2").setValue(["title": "We are awesome!"])
    }
}
