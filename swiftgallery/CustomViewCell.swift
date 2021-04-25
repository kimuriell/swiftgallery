//
//  CustomViewCell.swift
//  swiftgallery
//
//  Created by TEST on 4/25/21.
//

import UIKit

class CustomViewCell: UICollectionViewCell {
    
    private var label : UILabel = UILabel()
    
    func setLabel(_ value:String) {
        self.label.text = value
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.contentMode = .scaleAspectFill
        label.textAlignment = NSTextAlignment.center
        
        self.contentView.addSubview(label)

        self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant:0).isActive = true
        self.label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:0).isActive = true
        self.label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:0).isActive = true
        self.label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:0).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
