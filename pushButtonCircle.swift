//
//  pushButtonCircle.swift
//  longtouch
//
//  Created by ROBERT Arthur on 12/11/2015.
//  Copyright © 2015 ROBERT Arthur. All rights reserved.
//

import UIKit

@IBDesignable

class pushButtonCircle: UIButton {
    
    var idle = true
    
    @IBInspectable
    var favoriteColor: UIColor =    UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0){
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable
    private var id: CGFloat =  CGFloat(100){
        didSet {
            
        }
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: CGRect.init(x: rect.origin.x, y: rect.origin.y, width: rect.width, height: rect.height));
    
        path.fillWithBlendMode(CGBlendMode.Overlay, alpha: 0.25)
        
         let path2 = UIBezierPath(ovalInRect: CGRect.init(x: (rect.origin.x + rect.width/4), y: (rect.origin.y + rect.height/4), width: rect.width/2, height: rect.height/2));
        path2.fillWithBlendMode(CGBlendMode.Overlay, alpha: 0.25)
        
        
        UIButton.animateWithDuration(1.0, delay: 0.5,options: [ .Autoreverse], animations: {
            self.alpha = 0.5
           // path.applyTransform(CGAffineTransformMakeScale(0.8, 0.8))
            }, completion: nil)
    
       
    }
   func buttonPressed(sender : AnyObject){
        print("pressed")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchBeganAnim();
        self.idle = false
         print("button Began")
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchEndedAnim();
        self.idle = true
        print("button end")
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func touchBeganAnim(){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.2)
        self.alpha = 0.5
        self.transform = CGAffineTransformMakeScale(0.8, 0.8)
        UIView.commitAnimations()
      
    }

    func touchEndedAnim(){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.2)
        self.alpha = 0.75
        self.transform = CGAffineTransformMakeScale(1, 1)
        UIView.commitAnimations()
    }
    
    private func updateLayerProperties()
    {
       
    }


}
