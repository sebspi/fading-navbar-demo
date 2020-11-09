//
//  ViewController.swift
//  fading-navbar-demo
//
//  Created by Sebastian Spies on 05.11.20.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTopSpaceConstraint: NSLayoutConstraint!
    
    private var originalImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        originalImage = imageView.image
        self.navigationItem.title = "Fading Navbar Demo"
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let topPadding = window.safeAreaLayoutGuide.layoutFrame.minY
            labelTopSpaceConstraint.constant = labelTopSpaceConstraint.constant - navigationController!.navigationBar.frame.height - topPadding
            imageViewTopConstraint.constant = -navigationController!.navigationBar.frame.height - topPadding
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = scrollView.contentOffset.y / (labelTopSpaceConstraint.constant)
        if alpha >= 1 {
            navigationController?.navigationBar.backgroundColor = UIColor.systemRed.withAlphaComponent(alpha)
        } else {
            navigationController?.navigationBar.backgroundColor = UIColor.systemRed.withAlphaComponent(0)
        }
        self.imageView.image = originalImage.alpha((labelTopSpaceConstraint.constant - scrollView.contentOffset.y) / labelTopSpaceConstraint.constant)
    }
}

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
