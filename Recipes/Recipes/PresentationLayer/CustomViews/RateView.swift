//
//  RateView.swift
//  Recipes
//
//  Created by Marian on 11/21/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

protocol RateViewDelegate: class {
    func rateView(rateView:RateView, ratingDidChange rating:Double)
}

class RateView: UIView {
    
    var notSelectedImage:UIImage? {
        didSet {
            self.refresh()
        }
    }
    
    var halfSelectedImage:UIImage? {
        didSet {
            self.refresh()
        }
    }
    
    var fullSelectedImage:UIImage? {
        didSet {
            self.refresh()
        }
    }
    
    var rating:Double = 0.0 {
        didSet {
            self.refresh()
        }
    }
    
    var editable:Bool = false
    var imageViews:[UIImageView]?
    
    var maxRating:Int = 5 {
        didSet {
            //remove the old image views
            if let imageViews = imageViews {
                for imageView in imageViews {
                    imageView.removeFromSuperview()
                }
            }
            
            //add new image views
            imageViews = [UIImageView]()
            for _ in 0 ... maxRating-1 {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                self.imageViews?.append(imageView)
                self.addSubview(imageView)
            }
            self.setNeedsLayout()
            self.refresh()
        }
    }
    
    let midMargin:CGFloat = 0
    let leftMargin:CGFloat = 0
    let minImageSize:CGSize = CGSize(width: 5.0, height: 5.0)
    weak var delegate:RateViewDelegate?
    
    func refresh() {
        if let imageViews = imageViews {
            for index in 0..<imageViews.count {
                let imageView = imageViews[index]
                if self.rating >= Double(index + 1) {
                    imageView.image = self.fullSelectedImage
                }
                else if self.rating > Double(index) {
                    imageView.image = self.halfSelectedImage
                }
                else {
                    imageView.image = self.notSelectedImage
                }
            }
        }
    }
    
    /*
     This function gets called whenever the frame of our view changes, and we're expected
     to set up the frames of all of our subviews to the appropriate size for that space (the new frame).
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.notSelectedImage != nil else {
            return
        }
        
        if let imageViews = imageViews {
            let sideMargin = self.leftMargin * 2.0
            let middleMargin = self.midMargin * CGFloat(imageViews.count)
            let desiredImageWidth = (self.frame.size.width - sideMargin - middleMargin) / CGFloat(imageViews.count)
            let imageWidth = max(self.minImageSize.width, desiredImageWidth)
            let imageHeight = max(self.minImageSize.height, self.frame.size.height)
            for (index, imageView) in imageViews.enumerated() {
                imageView.frame = CGRect(x: self.leftMargin + CGFloat(index) * (self.midMargin + imageWidth), y: 0, width: imageWidth, height: imageHeight)
            }
        }
    }
    
    func handleTouchAtLocation(touchLocation:CGPoint) {
        guard self.editable else {
            return
        }
        
        if let imageViews = imageViews {
            var newRating:Double = 0.0
            for i in (0...imageViews.count-1).reversed(){
                let imageView = imageViews[i]
                if touchLocation.x > imageView.frame.origin.x {
                    newRating = Double(i) + 1.0
                    break
                }
            }
            self.rating = newRating
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        self.handleTouchAtLocation(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        self.handleTouchAtLocation(touchLocation: touchLocation)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.rateView(rateView: self, ratingDidChange: self.rating)
    }
    
}
