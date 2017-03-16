//
//  TextParticleCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/13/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class TextParticleCell: UICollectionViewCell
{
    @IBOutlet weak var textView: UITextView!
    
    func updateText(_ text: String)
    {
        textView.text = text
    }
}
