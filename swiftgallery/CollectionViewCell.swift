//
//  CollectionViewCell.swift
//  swiftgallery
//
//  Created by TEST on 4/24/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabel(_ value:String) {
        self.label.text = value
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
