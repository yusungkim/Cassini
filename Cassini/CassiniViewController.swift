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
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool
    {
        if primaryViewController.contents == self {
            if let imageVC = secondaryViewController.contents as? ImageViewController {
                if imageVC.imageURL == nil {
                    return true // I (cassini view controller) will do the collapse job, but actually I do nothing as result it is not going to collapse.
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
