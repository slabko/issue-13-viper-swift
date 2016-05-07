//
//  AddWireframe.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit
import Swinject

let AddViewControllerIdentifier = "AddViewController"

class AddWireframe : NSObject, UIViewControllerTransitioningDelegate {

    var addPresenter : AddPresenter?
    var presentedViewController : UIViewController?
    weak var presentingViewController : UIViewController?

    func presentAddInterfaceFromViewController(viewController: UIViewController) {
        presentingViewController = viewController
        let newViewController = addViewController()
        newViewController.eventHandler = addPresenter
        newViewController.modalPresentationStyle = .Custom
        newViewController.transitioningDelegate = self
        
        addPresenter?.configureUserInterfaceForPresentation(newViewController)
        
        viewController.presentViewController(newViewController, animated: true, completion: nil)
        
        presentedViewController = newViewController
    }
    
    func dismissAddInterface() {
        presentingViewController?.viewWillAppear(true)
        presentedViewController?.dismissViewControllerAnimated(true, completion: { _ in 
            self.presentingViewController?.viewDidAppear(true)
        })
    }
    
    func addViewController() -> AddViewController {
        let storyboard = mainStoryboard()
        let addViewController: AddViewController = storyboard.instantiateViewControllerWithIdentifier(AddViewControllerIdentifier) as! AddViewController
        return addViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddDismissalTransition()
    }
    
   func animationControllerForPresentedController(presented: UIViewController,
                                                  presentingController presenting: UIViewController,
                                                  sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddPresentationTransition()
    }
}
