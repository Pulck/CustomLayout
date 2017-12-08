//
//  TransitionViewController.swift
//  CustomLayout
//
//  Created by Colick on 2017/12/8.
//  Copyright © 2017年 The Big Nerd. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    @IBOutlet var transitingView: UIView!
    @IBOutlet var transitedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("TransitedView", owner: self, options: nil)
        Bundle.main.loadNibNamed("TransitingView", owner: self, options: nil)
        transitedView.isHidden = true
        view.addSubview(transitingView)
        view.addSubview(transitedView)
    }

    lazy var transitionAnimation: CATransition = {
        let tran = CATransition()
        tran.startProgress = 0.0
        tran.endProgress = 1.0
        tran.type = "cube"
        tran.duration = 1.0
        
        return tran
    }()
    
    @IBAction func backToTransitingView(_ sender: UIButton) {
        transitionAnimation.subtype = kCATransitionFromLeft
        transitingView.layer.add(transitionAnimation, forKey: "transition")
        transitedView.layer.add(transitionAnimation, forKey: "transition")
        transitingView.isHidden = false
        transitedView.isHidden = true
    }
    
    @IBAction func changeToTransitedView(_ sender: UIButton) {
        transitionAnimation.subtype = kCATransitionFromRight
        transitingView.layer.add(transitionAnimation, forKey: "transition")
        transitedView.layer.add(transitionAnimation, forKey: "transition")
        transitingView.isHidden = true
        transitedView.isHidden = false
    }    

}
