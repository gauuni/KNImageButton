//
//  KNImageButton.swift
//  KNImageButton
//
//  Created by Nguyen Khoi Nguyen on 12/21/16.
//  Copyright © 2016 CANGroup. All rights reserved.
//

import UIKit

class KNImageButton: UIView {

    //
    // MARK: - Public property
    
    //
    // MARK: - Image
    @IBInspectable var image: UIImage?{
        didSet{
            imageViewIcon.image = image
        }
    }
    
    //
    // MARK: - Text
    @IBInspectable var title: String?{
        didSet{
            labelTitle.text = title
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.black{
        didSet{
            labelTitle.textColor = textColor
        }
    }
    
    //
    // MARK: - View interface
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    
    
    private var isLeftImage: Bool = false

    //
    // MARK: - Private property
    private var buttonAction: UIButton!
    private var labelTitle: UILabel!
    private var imageViewIcon: UIImageView!
    private var containerView: UIView!
    
    private var imageViewWidth: CGFloat = 0
    private var labelTitleWidth: CGFloat = 0
    
    init(frame: CGRect, isLeftImage: Bool=false) {
        super.init(frame: frame)
        self.isLeftImage = isLeftImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViewWidth = frame.size.width * 0.3 - 16
        labelTitleWidth = frame.size.width - imageViewWidth - 16

        setupContainerView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Init
    private func setupContainerView(frame: CGRect=CGRect.zero){
        containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        
        if isLeftImage{
            setUpImageViewIcon(frame: frame)
            setupTitleLabel(frame: frame)
        }else{
            setupTitleLabel(frame: frame)
            setUpImageViewIcon(frame: frame)
        }
        
        var containerFrame = containerView.frame
        containerFrame.size.width = labelTitleWidth + imageViewWidth
        containerFrame.size.height = frame.size.height
        containerFrame.origin.x = (frame.size.width  - containerFrame.size.width) / 2
        containerFrame.origin.y = 0
        containerView.frame = containerFrame
        
        self.addSubview(containerView)
        containerView.addSubview(labelTitle)
        containerView.addSubview(imageViewIcon)
        
        setupButtonAction(frame: frame)
        self.addSubview(buttonAction)
    }
    
    private func setupTitleLabel(frame: CGRect=CGRect.zero){
        labelTitle = UILabel()
        
        //
        // Check if left image
        // then x = imageViewWidth
        // else x = 0
        var xPoint : CGFloat = 0
        if isLeftImage{ xPoint = imageViewWidth }
        
        if let title = self.title{
            //
            // If titleWidth < labelTitleWidth
            // then labelTitleWidth = titleWidth
            let titleWidth = title.widthWithConstrainedHeight(height: frame.height, font: labelTitle.font)
            if titleWidth < labelTitleWidth{
                labelTitleWidth = titleWidth
            }
        }
        
        let frame = CGRect(x: xPoint, y: 0, width: labelTitleWidth, height: frame.height)
        labelTitle.frame = frame
        labelTitle.text = title
        labelTitle.textAlignment = .right
        labelTitle.textColor = textColor
    }
    
    private func setupButtonAction(frame: CGRect=CGRect.zero){
        buttonAction = UIButton(type: .custom)
        buttonAction.backgroundColor = UIColor.clear
        var buttonFrame = buttonAction.frame
        buttonFrame.origin = CGPoint.zero
        buttonFrame.size = frame.size
        buttonAction.frame = buttonFrame
    }
    
    private func setUpImageViewIcon(frame: CGRect=CGRect.zero){
        imageViewIcon = UIImageView()
        
        //
        // Check if left image
        // then x = 0
        // else x = labelTitleWidth
        var xPoint : CGFloat = 0
        if !isLeftImage{ xPoint = labelTitleWidth }
        
        let imageHeight = frame.height/2
        
        if let image = self.image{
            let newImage = image.scaledWidthWithHeight(height: imageHeight)
            imageViewWidth = newImage.size.width
            self.image = newImage
        }
        
        let frame = CGRect(x: xPoint, y: (frame.height-imageHeight)/2, width: imageViewWidth, height: imageHeight)
        imageViewIcon.frame = frame
        imageViewIcon.contentMode = .scaleAspectFit
        imageViewIcon.image = image
    }
    
    //
    // MARK: - Public methods
    //
    /** 
     Add target 
     */
    func addTarget(target: Any?, action: Selector, for event: UIControlEvents){
        buttonAction.addTarget(target, action: action, for: event)
    }
}

extension String{
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIImage{
    func scaledWidthWithHeight(height: CGFloat) -> UIImage{
        let oldHeight = self.size.height
        let scaleFactor = height / oldHeight

//        let newHeight = oldHeight * scaleFactor
        let newWidth = self.size.width * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:height))
        self.draw(in: CGRect(x:0, y:0, width:newWidth, height:height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage == nil ? UIImage() : newImage!
    }
}
