//
//  MainController.swift
//  swiftgallery
//
//  Created by TEST on 4/24/21.
//

import UIKit

class MainController: UIViewController,
                      UICollectionViewDelegate,
                      UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var buttonDogs: UIButton!
    @IBOutlet weak var buttonCats: UIButton!
    
    @objc func btDogsClicked() {
        self.buttonDogs.tintColor = UIColor.systemBlue
        self.buttonCats.tintColor = UIColor.black
        
        items = ["17", "18", "19", "20", "21"]
        collectionView.reloadData()
        
    }
    
    @objc func btCatsClicked() {
        self.buttonDogs.tintColor = UIColor.black
        self.buttonCats.tintColor = UIColor.systemBlue
        
        items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
        collectionView.reloadData()
        
//        let cell = collectionView.dequeueReusableCell(  (withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CustomViewCell
    }
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    let reuseIdentifier = "dataCell"
    
    override func viewDidLoad() {
                
        super.viewDidLoad()
        
        self.buttonDogs.tintColor = UIColor.black
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
//        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  
        self.buttonDogs.addTarget(self, action: #selector(btDogsClicked), for: .touchDown)
        self.buttonCats.addTarget(self, action: #selector(btCatsClicked), for: .touchDown)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.48,
                      height: collectionView.frame.width*0.48)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CustomViewCell

        //cell.setLabel(self.items[indexPath.row])
       // cell.textValue.text = "qwerty" //  self.items[indexPath.row]
//        cell.label.text = self.items[indexPath.row]
//        cell.label.textColor = UIColor.black
        cell.setLabel(self.items[indexPath.row])
//        cell.backgroundColor = UIColor.red
        //cell.label.backgroundColor = .red
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 18
        

        return cell
    }
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomViewCell
        cell.backgroundColor = UIColor.red
    }

    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomViewCell
        cell.backgroundColor = UIColor.white
    }

}
