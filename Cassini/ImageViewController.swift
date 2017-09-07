//
//  ImageViewController.swift
//  Cassini
//
//  Created by KimYusung on 9/7/17.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // Model
    var imageURL: URL? {
        didSet {
            fetchImage()
        }
    }
    
    // View
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageURL = DemoURL.Standford
    }
    
    // Controll Things
    
    private func fetchImage() {
        var image: UIImage? {
            get {
                return imageView.image
            }
            set {
                imageView.image = newValue
            }
        }
        // get newImage From URL
        if let url = imageURL {
            if let dataContent = try? Data(contentsOf: url) {
                image = UIImage(data: dataContent)
            }
        }
        
    }

}
