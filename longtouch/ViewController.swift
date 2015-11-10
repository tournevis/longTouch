//
//  ViewController.swift
//  longtouch
//
//  Created by ROBERT Arthur on 10/11/2015.
//  Copyright © 2015 ROBERT Arthur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var blurFirstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    
    var layerCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Long touch recognizer init */
        let longTouch: UILongPressGestureRecognizer = UILongPressGestureRecognizer (target: self, action: "longTouch:")
        longTouch.minimumPressDuration = 0.8
        self.view.addGestureRecognizer(longTouch)
        
        /* Image Init */
        let firstPickImage = UIImage(named:"impression1")
        self.firstImage.image = firstPickImage
        /* Bluriing First Image  */
        self.blurFirstImage.image = self.blurImage(15.0, image : firstPickImage!);
        self.blurFirstImage.alpha = 0.0
        
        
        /* Second Image Init, Etc */
        let secondPickimage = UIImage(named:"impression2")
        self.secondImage.transform  = CGAffineTransformMakeScale(1.0 , 1.0)
        self.secondImage.image = secondPickimage
        self.secondImage.alpha = 0.0
        }
    
    func longTouch( longTouch : UIGestureRecognizer){
        if(longTouch.state == UIGestureRecognizerState.Began){
            print("Began")
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
            UIView.setAnimationDuration(0.4)
            //self.firstImage.image?.setValue(3.0, forKey: "scale")
            self.blurFirstImage.alpha = 0.2
            self.firstImage.alpha = 0.5
            self.secondImage.hidden = false
            UIView.commitAnimations()
        }else if(longTouch.state == UIGestureRecognizerState.Ended) {
            print("Ended")
            animationDepthIn(self.firstImage, image1Blur: self.blurFirstImage, image2: self.secondImage );
            
        
        }
        
    }
    func touchBlur(image1 : UIImageView , image1Blur: UIImageView){
        /* x */
    
    }
    
    func animationDepthIn(image1 : UIImageView , image1Blur: UIImageView, image2: UIImageView){
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


}

