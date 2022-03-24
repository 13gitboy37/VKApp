//
//  LoadScreenVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.01.2022.
//

import UIKit

class LoadScreenVC: UIViewController {
    
    @IBOutlet var loadDot1: UIImageView!
    @IBOutlet var loadDot2: UIImageView!
    @IBOutlet var loadDot3: UIImageView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        let duration = 1.0

        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: .repeat,
            animations: {
                self.loadDot1.alpha = 0.1
            },
         completion: { isComplited in
             self.loadDot1.alpha = 0.9
                   })
        UIView.animate(
            withDuration: duration,
            delay: 0.33,
            options: .repeat,
            animations: {
                self.loadDot2.alpha = 0.1
            },
         completion: { isComplited in
             self.loadDot2.alpha = 0.9
                   })
        UIView.animate(
            withDuration: duration,
            delay: 0.66,
            options: .repeat,
            animations: {
                self.loadDot3.alpha = 0.1
            },
         completion: { isComplited in
             self.loadDot3.alpha = 0.9
             
                   })
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as!             VKLoginVC
            nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
            
        }
    }
}
