//
//  DescriptionCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit
import AnimatedTextInput

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var descriptionTextField: AnimatedTextInput!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        descriptionTextField.style = DescriptionInputStyle() as AnimatedTextInputStyle
        descriptionTextField.placeHolderText = "Description"
        descriptionTextField.type = .multiline
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    struct DescriptionInputStyle: AnimatedTextInputStyle {
        
        let activeColor = UIColor.gray.withAlphaComponent(0.3)
        let inactiveColor = UIColor.gray.withAlphaComponent(0.3)
        let lineInactiveColor = UIColor.clear
        let errorColor = UIColor.red
        let textInputFont = UIFont.systemFont(ofSize: 20)
        let textInputFontColor = UIColor.black
        let placeholderMinFontSize: CGFloat = 9
        let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
        let leftMargin: CGFloat = 15
        let topMargin: CGFloat = 20
        let rightMargin: CGFloat = 10
        let bottomMargin: CGFloat = 15
        let yHintPositionOffset: CGFloat = 7
        let yPlaceholderPositionOffset: CGFloat = 7
        
    }
}
