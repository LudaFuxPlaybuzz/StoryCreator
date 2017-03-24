//
//  TitleAndCoverCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit
import AnimatedTextInput
import DKImagePickerController

@objc protocol PresentViewControllerDelegate: class
{
    func present(_ viewController:UIViewController, animated: Bool)
}

class TitleCoverAndDescriptionHeader: UICollectionReusableView {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleTextField: AnimatedTextInput!
    @IBOutlet weak var descriptionTextField: AnimatedTextInput!
    
    weak var delegate: PresentViewControllerDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        titleTextField.style = TitleInputStyle() as AnimatedTextInputStyle
        titleTextField.backgroundColor = UIColor.clear
        titleTextField.placeHolderText = "Your Awesome Title"
        
        descriptionTextField.style = DescriptionInputStyle() as AnimatedTextInputStyle
        descriptionTextField.backgroundColor = UIColor.clear
        descriptionTextField.placeHolderText = "Sexy description summarizing this amazing story"
        descriptionTextField.type = .multiline
    }

    struct TitleInputStyle: AnimatedTextInputStyle {
        
        let activeColor = UIColor.lightGray
        let inactiveColor = UIColor.black
        let lineInactiveColor = UIColor.lightGray
        let errorColor = UIColor.red
        let textInputFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
        let textInputFontColor = UIColor.black
        let placeholderMinFontSize: CGFloat = 9
        let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
        let leftMargin: CGFloat = 0
        let topMargin: CGFloat = 20
        let rightMargin: CGFloat = 15
        let bottomMargin: CGFloat = 10
        let yHintPositionOffset: CGFloat = 7
        let yPlaceholderPositionOffset: CGFloat = 7
        
    }
    
    struct DescriptionInputStyle: AnimatedTextInputStyle {
        
        let activeColor = UIColor.lightGray
        let inactiveColor = UIColor.gray
        let lineInactiveColor = UIColor.lightGray
        let errorColor = UIColor.red
        let textInputFont = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
        let textInputFontColor = UIColor.black
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
        
        self.delegate?.present(pickerController, animated: true)
        
    }
}
