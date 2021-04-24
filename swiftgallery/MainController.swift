//
//  MainController.swift
//  swiftgallery
//
//  Created by TEST on 4/24/21.
//

import UIKit

class MainController: UIViewController{

    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var buttonDogs: UIButton!
    @IBOutlet weak var buttonCats: UIButton!
    
    @IBAction func btDogsClicked() {
        topLabel.text = "Dogs"
    }
    
    @IBAction func btCatsClicked() {
        topLabel.text = "Cats"
    }
    
    
    override func viewDidLoad() {
        topLabel.text = "Simple Gallery"
        
        buttonDogs.addTarget(self, action: "btDogsClicked", for: .touchUpInside)
        buttonCats.addTarget(self, action: "btCatsClicked", for: .touchUpInside)
        
//        imageCollection.
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
