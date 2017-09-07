//
//  CassiniViewController.swift
//  Cassini
//
//  Created by KimYusung on 9/7/17.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""] {
            if let imageVC = segue.destination.contents as? ImageViewController {
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
    // set the splitVC's delegate in the very early stage.
    // splitViewController? is a point for the splitVC who is pointing me(cassiniVC).
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool
    {
        // check whether splitVC's master is me(cassiniVC).
        if primaryViewController.contents == self {
            
            // check splitVC's detail is imageVC
            if let imageVC = secondaryViewController.contents as? ImageViewController {
                
                // check imageVC's imageURL is set (which means have image),
                // if not (which means the initial loading stage), collapse (which means show master view)
                if imageVC.imageURL == nil {
                    
                    // I (cassini view controller) will do the collapse job,
                    // but actually I do nothing, because I dont have a code for it.
                    // As result it is not going to collapse.
                    return true
                }
            }
        }
        return false // You (split view controller) do it(collapse thing).
    }
}

extension UIViewController {
    var contents: UIViewController? {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController
        } else {
            return self
        }
    }
}
