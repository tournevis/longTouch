//
//  ViewController.swift
//  longtouch
//
//  Created by ROBERT Arthur on 10/11/2015.
//  Copyright © 2015 ROBERT Arthur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var blurFirstImage: UIImageView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet weak var blurSecondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var button1: pushButtonCircle!
    @IBOutlet weak var myTitle: UITextView!
    @IBOutlet weak var textView: UITextView!
    
    var layerCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Long touch recognizer init */4
        let longTouch: UILongPressGestureRecognizer = UILongPressGestureRecognizer (target: self, action: "longTouch:")
        longTouch.minimumPressDuration = 0.8
        self.view.addGestureRecognizer(longTouch)
        
        /* Layer */
        
        self.layerCount = 0;
        
        
        /* Text INIT  */
        
        self.myTitle.text = " AWESOME TITLE ONE "
        self.textView.text = " YOLO loreum ipsum tout ca tout ça oker ?  "
        
        /* Image Init */
    
        self.firstImage.image =  UIImage(named:"impression_1")
        self.secondImage.image = UIImage(named:"impression_2_1")
        self.thirdImage.image = UIImage(named:"impression_3_A")
        
        /* Bluring Image  */
        
        self.blurFirstImage.image = self.blurImage(15.0, image : self.firstImage.image! );
       self.blurSecondImage.image = self.blurImage(15.0, image : self.secondImage.image! );
        self.blurFirstImage.alpha = 0.0
        self.blurSecondImage.alpha = 0.0
        
        /* Second Image Init, Etc */

        self.secondImage.transform  = CGAffineTransformMakeScale(1.0 , 1.0)
        self.secondImage.alpha = 0.0
        
        
        /* Third Image Init, Etc  */
        
        self.thirdImage.transform  = CGAffineTransformMakeScale(1.0 , 1.0)
        
        self.thirdImage.alpha = 0.0
        
    }
    
    func longTouch( longTouch : UIGestureRecognizer){
        if(longTouch.state == UIGestureRecognizerState.Began){
            print("view Began")
            if(self.layerCount == 0){
                touchBlur(self.firstImage, image1Blur: self.blurFirstImage);
            }else if(self.layerCount == 1){
                touchBlur(self.secondImage, image1Blur: self.blurSecondImage);

            }
            
        }else if(longTouch.state == UIGestureRecognizerState.Ended) {
            print("view Ended")
            self.layerCount = self.layerCount +  1 ;
            if(self.layerCount == 1){
                animationDepthIn(self.firstImage, image1Blur: self.blurFirstImage, image2: self.secondImage );
            }else if(self.layerCount == 2){
                animationDepthIn(self.secondImage, image1Blur: self.blurSecondImage, image2: self.thirdImage );
            }
            print(self.layerCount)
            
        }
        
    }
    func touchBlur(image1 : UIImageView , image1Blur: UIImageView){
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.4)
        image1Blur.alpha = 0.2
        image1.alpha = 0.5
        UIView.commitAnimations()
    
    }
    
    func animationDepthIn(image1 : UIImageView , image1Blur: UIImageView, image2: UIImageView){
        image2.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.6)
        //self.firstImage.image?.setValue(3.0, forKey: "scale")
        image1 .transform = CGAffineTransformMakeScale(4.0 , 4.0)
        image1 .alpha = 0.0
        image1Blur.transform  = CGAffineTransformMakeScale(4.0 , 4.0)
        image1Blur.alpha = 0.0
        image2.transform  = CGAffineTransformMakeScale(1.1 , 1.1)
        image2.alpha = 1.0
        UIView.commitAnimations()
    }
    func animationDepthOut(image1 : UIImageView , image1Blur: UIImageView, image2: UIImageView){
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func blurImage(blurValue: Float , image: UIImage) -> UIImage {
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        blurfilter!.setValue(blurValue, forKey: "inputRadius")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        
        return UIImage(CIImage: resultImage)
    }
    
     func drawRect(rect: CGRect) {
        // Get the Graphics Context
        var context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 5.0);
        
        // Set the circle outerline-colour
        UIColor.redColor().set()
        
       // CGContextAddArc(context, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##radius: CGFloat##CGFloat#>, <#T##startAngle: CGFloat##CGFloat#>, <#T##endAngle: CGFloat##CGFloat#>, <#T##clockwise: Int32##Int32#>)
        // Create Circle
        //CGContextAddArc(context, (view.size.width)/2, frame.size.height/2, (ViewController.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        
        // Draw
        CGContextStrokePath(context);
    }


}

