//
//  ImageViewCell.swift
//  swiftgallery
//
//  Created by TEST on 4/25/21.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    private var imageView : UIImageView = UIImageView()
    
    func setImage(_ value:UIImage) {
        self.imageView.image = value
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        
        self.contentView.addSubview(imageView)

        self.imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant:0).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:0).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:0).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:0).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
