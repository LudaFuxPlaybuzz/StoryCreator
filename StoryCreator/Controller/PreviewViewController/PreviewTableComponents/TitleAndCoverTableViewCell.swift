//
//  TitleAndCoverTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit
import AnimatedTextInput
import DKImagePickerController

class TitleAndCoverTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleTextField: AnimatedTextInput!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        titleTextField.style = TitleInputStyle() as AnimatedTextInputStyle
        titleTextField.backgroundColor = UIColor.clear
        titleTextField.placeHolderText = "Title"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    struct TitleInputStyle: AnimatedTextInputStyle {
        
        let activeColor = UIColor.white
        let inactiveColor = UIColor.white
        let lineInactiveColor = UIColor.white.withAlphaComponent(0.3)
        let errorColor = UIColor.red
        let textInputFont = UIFont.systemFont(ofSize: 25)
        let textInputFontColor = UIColor.white
        let placeholderMinFontSize: CGFloat = 9
        let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
        let leftMargin: CGFloat = 0
        let topMargin: CGFloat = 20
        let rightMargin: CGFloat = 15
        let bottomMargin: CGFloat = 10
        let yHintPositionOffset: CGFloat = 7
        let yPlaceholderPositionOffset: CGFloat = 7
        
    }
    
    @IBAction func didPressCameraButton(_ sender: Any)
    {
        let pickerController = DKImagePickerController()
        pickerController.singleSelect = true
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            if assets.count > 0
            {
                let asset: DKAsset = assets[0]
                asset.fetchImageWithSize(self.coverImage.frame.size, completeBlock: { image, info in
                    self.coverImage.image = image
                })
            }
        }
        
//        self.present(pickerController, animated: true) {}
    }
}
