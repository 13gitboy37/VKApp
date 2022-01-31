//
//  FullScreenPhotoVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.01.2022.
//

import UIKit

class FullScreenPhotoVC: UIViewController {
   
    var leftImage = UIImage()
    var centralImage = UIImage()
    var rightImage = UIImage()
    var namePhoto = String()
    var photo = [String]()
    var indexPath = Int()
    
    var leftIndex = Int()
    var centralIndex = Int()
    var rightIndex = Int()
    
    
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var centralImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    
    private var propertyAnimator: UIViewPropertyAnimator!
    private var isAnimated = false
    
    private let duration = 1.0
     
    
    @IBAction func backToPhotos(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

     //   centralImageView.isUserInteractionEnabled = true
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = .left
        self.view!.addGestureRecognizer(swipeLeft)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = .right
        self.view!.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        self.view!.addGestureRecognizer(swipeDown)
        
        self.leftIndex = self.indexPath - 1
        self.centralIndex = self.indexPath
        self.rightIndex = self.indexPath + 1
        
        if indexPath == 0 {
            leftIndex = photo.endIndex - 1
            leftImageView.image = UIImage(named: photo[leftIndex]) ?? UIImage()
            centralImageView.image = UIImage(named: photo[centralIndex]) ?? UIImage()
            rightImageView.image = UIImage(named: photo[rightIndex]) ?? UIImage()
        } else if indexPath == photo.endIndex - 1{
            rightIndex = 0
            leftImageView.image = UIImage(named: photo[leftIndex]) ?? UIImage()
            centralImageView.image = UIImage(named: photo[centralIndex]) ?? UIImage()
            rightImageView.image = UIImage(named: photo[rightIndex]) ?? UIImage()
        } else if indexPath != 0 && indexPath != photo.endIndex - 1 {
            leftImageView.image = UIImage(named: photo[leftIndex]) ?? UIImage()
            centralImageView.image = UIImage(named: photo[centralIndex]) ?? UIImage()
            rightImageView.image = UIImage(named: photo[rightIndex]) ?? UIImage()
        }
        
        
        
        
        //MARK: Animation transition
        
        
        
    }
    
    
    //respond Swipe Direction
    
    @objc
    private func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) -> Void {
        let positionX = self.centralImageView.frame.origin.x
        guard
            let swipeGesture = gesture as? UISwipeGestureRecognizer
        else {return}
        switch swipeGesture.direction {
            
            
            
            
        
            //MARK: rotation to left
        case .right:
            UIImageView.animateKeyframes(
                withDuration: duration,
                delay: 0,
                options: [],
                animations: {
                    
                    UIImageView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5,
                        animations: {
                            self.centralImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        })
                    UIImageView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.centralImageView.frame.origin.x += 500
                        })
                    UIImageView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.leftImageView.frame.origin.x = positionX
                        })
                },
                completion:{ isComplited in
                    
                    self.leftIndex -= 1
                    self.centralIndex -= 1
                    self.rightIndex -= 1
                    
                    if self.leftIndex < 0 {
                        self.leftIndex = self.photo.endIndex - 1
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                        
                    } else if self.centralIndex < 0  {
                        self.centralIndex = self.photo.endIndex - 1
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                   //     self.rightImageView.image = UIImage(named: self.photo[self.indexPath + 1])
                    } else if self.rightIndex < 0 {
                        self.rightIndex = self.photo.endIndex - 1
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                    } else {
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                    }
                } )
            
            
            
            
            
            
            //MARK: Rotarion to right
        case .left:
            UIImageView.animateKeyframes(
                withDuration: duration,
                delay: 0,
                options: [],
                animations: {
                    
                    UIImageView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5,
                        animations: {
                            self.centralImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        })
                    UIImageView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.centralImageView.frame.origin.x -= 500
                        })
                    UIImageView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.rightImageView.frame.origin.x = positionX
                        })
                },
                completion:{ isComplited in
                    self.centralImageView.image = self.rightImageView.image
                    self.centralImageView.transform = .identity
                    
                    self.leftIndex += 1
                    self.centralIndex += 1
                    self.rightIndex += 1
                    
                    if self.leftIndex > self.photo.endIndex - 1 {
                        self.leftIndex = 0
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                        
                    } else if self.centralIndex > self.photo.endIndex - 1 {
                        self.centralIndex = 0
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                        
                    } else if self.rightIndex > self.photo.endIndex - 1 {
                        self.rightIndex = 0
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                    } else {
                        self.leftImageView.image = UIImage(named: self.photo[self.leftIndex])
                        self.centralImageView.image = UIImage(named: self.photo[self.centralIndex])
                        self.rightImageView.image = UIImage(named: self.photo[self.rightIndex])
                        self.centralImageView.transform = .identity
                    }

                } )
        case .down:
            self.dismiss(animated: true, completion: nil)
        default:
            return
        }
    }
}
