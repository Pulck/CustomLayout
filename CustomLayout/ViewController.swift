//
//  ViewController.swift
//  CustomLayout
//
//  Created by Colick on 2017/11/27.
//  Copyright © 2017年 The Big Nerd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view1: UILabel!
    @IBOutlet weak var view2: UILabel!
    @IBOutlet weak var layerView: UILabel!
    
    override func viewDidLoad() {
        
        view1.layer.masksToBounds = true
        view.layer.cornerRadius = 2.0
        print(#function)
    }
    
    @IBAction func startAnimation(_ sender: UIButton) {
        print(#function)
        UIView.animate(withDuration: 1.0,
                       delay: 1.0,
                       options: [.curveEaseOut],
                       animations: {
                        self.view1.alpha = 0.0
                        UIView.animate(withDuration: 0.2,
                                       delay: 0.0,
                                       options:
                            [.overrideInheritedCurve,
                            .overrideInheritedDuration,
                            .curveLinear,
                            .repeat,
                            .autoreverse],
                                       animations: {
                                        UIView.setAnimationRepeatCount(2.5)
                                        self.view2.alpha = 0.0
                        },
                                       completion: nil)
        }) { finished in
            if finished {
                UIView.animate(withDuration: 1.0) {
                    self.view1.alpha = 1.0
                    self.view2.alpha = 1.0
                    UIView.animate(withDuration: 1.0,
                                   delay: 1.0,
                                   options: [],
                                   animations: {
                                    let transform = self.view2.transform.rotated(by: CGFloat.pi)
                                    self.view2.transform = transform
                    },
                                   completion: {
                                    finished in
                                    UIView.animate(withDuration: 2.0,
                                                   animations: {
                                                    let transform = self.layerView.layer.transform
                                                    let rotate = CATransform3DRotate(transform, CGFloat.pi, 0, 1, 0)
                                                    self.layerView.layer.transform = rotate
                                    })
                    })
                }
            }
        }
    }
    
    
    @IBAction func presention(_ sender: UIButton) {
        let viewController = UIViewController()
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(back(_:)),
                         for: UIControlEvents.touchUpInside)
        let view = viewController.view!
        view.backgroundColor = UIColor.white
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        show(viewController, sender: self)
        
    }
    
    @objc
    func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

