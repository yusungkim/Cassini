//
//  ImageViewController.swift
//  Cassini
//
//  Created by KimYusung on 9/6/17.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // MARK: MODEL
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil { // if I am on screen, I am going to fetch image.
                fetchImage() // ネットから取ってくるので、時間かかるし、ちょっと複雑になるので、funcを使う
            }
        }
    }
    
    // MARK: VIEW
    fileprivate var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.maximumZoomScale = 2.0
            scrollView.minimumZoomScale = 0.5
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(imageView)
        
        // Debug
        //imageURL = DemoURL.Standford
    }
    
    // just before I am on screen. do whatever cost much, delay as much as you can. like fetchImage.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil { // if I dont have image yet, then fetch.
            fetchImage()
        }
    }
    
    // urlからデーターを読み込んで、image に入れる
    private func fetchImage() {
        if let url = imageURL {
            
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContent = try? Data(contentsOf: url)
                
                // this does beg the question, 
                // what if I am not interested in this url when I get back from the Data()
                if url == self?.imageURL { // if I am still interesting in the same url
                    if let imageData = urlContent {
                        DispatchQueue.main.async { // Do the UI things in main queue.
                            self?.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
    
    
    // imageは、データを保管しない。imageViewに保管／リードする作業をする
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.maximumZoomScale = 2.0
            scrollView?.minimumZoomScale = 0.5
            scrollView?.contentSize = imageView.frame.size // outlets are not set, during preparing
            spinner?.stopAnimating()
        }
    }
}

// Zooming　を使うためには、 UIScrollViewDelegate protocolを実装する必要がある。
// ここでは、extensionを使って、 ImageViewControllerをprotocolを継承するように拡張した。
// classの外で、 imageViewを呼び出すために、imageViewをfileprivateにした。
extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
