//
//  MainController.swift
//  swiftgallery
//
//  Created by TEST on 4/24/21.
//

import UIKit

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var buttonDogs: UIButton!
    @IBOutlet weak var buttonCats: UIButton!
    
    @objc func btDogsClicked() {
        topLabel.text = "Dogs"
    }
    
    @objc func btCatsClicked() {
        topLabel.text = "Cats"
    }
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    let reuseIdentifier = "dataCell"
    
    override func viewDidLoad() {
                
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  
        self.buttonDogs.addTarget(self, action: #selector(btDogsClicked), for: .touchUpInside)
        self.buttonCats.addTarget(self, action: #selector(btCatsClicked), for: .touchUpInside)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell

       // cell.label.text = self.items[indexPath.row]
        cell.backgroundColor = UIColor.red

        return cell
    }

}
