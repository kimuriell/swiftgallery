//
//  DetailViewController.swift
//  swiftgallery
//
//  Created by TEST on 4/27/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    let frame: CGRect
    let childViewController: UIViewController
    
    var imageView : UIImageView = UIImageView()
    
    func setImage(_ value:UIImage) {
        self.imageView.image = value
    }
     
     // MARK: Init
     
    init(frame: CGRect) {
        self.frame = frame
        childViewController = UIViewController()
         
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func viewDidLoad() {
    super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        
        let x = self.frame.width*0.05
        let s = self.frame.width*0.90
        let y = (self.frame.height-s)*0.5
        
        imageView.frame = CGRect(x: x, y: y, width: s, height: s)
        view.addSubview(imageView)
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        if isViewLoaded && view.window == nil {
            self.view = nil
        }
    }
}
