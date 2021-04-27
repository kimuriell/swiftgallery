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
    
    func downloadData(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        
        if let url = URL(string: urlString) {
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completionHandler(nil)
                } else {
                    completionHandler(data)
                }
            }
            dataTask.resume()
        } else {
            completionHandler(nil)
        }
    }
    
    @objc func btDogsClicked() {
        self.buttonDogs.tintColor = UIColor.systemBlue
        self.buttonCats.tintColor = UIColor.black
        
        if self.currentState == state.dogs {
            return
        }
        
        self.currentState = state.dogs
        collectionView.reloadData()
        
    }
    
    @objc func btCatsClicked() {
        self.buttonDogs.tintColor = UIColor.black
        self.buttonCats.tintColor = UIColor.systemBlue
        
        if self.currentState == state.cats {
            return
        }
        
        self.currentState = state.cats
        collectionView.reloadData()
    }
    
    private let reuseIdentifier = "dataCell"
    
    private var cats : Array<UIImage> = Array<UIImage>()
    private let catURLs : Array<String> = ["https://image.winudf.com/v2/image/Y29tLmJ1c2luZXNzLmNhdHNnYWxsZXJ5LmFpX3NjcmVlbl8xXzE1MzAwOTQ4NTRfMDE1/screen-1.jpg?fakeurl=1&type=.jpg",
        "https://image.winudf.com/v2/image/Y29tLmJ1c2luZXNzLmNhdHNnYWxsZXJ5LmFpX3NjcmVlbl8zXzE1MzAwOTQ4NTRfMDQw/screen-3.jpg?fakeurl=1&type=.jpg",
        "https://ichef.bbci.co.uk/news/976/cpsprodpb/12A9B/production/_111434467_gettyimages-1143489763.jpg",
        "https://static.scientificamerican.com/sciam/cache/file/92E141F8-36E4-4331-BB2EE42AC8674DD3_source.jpg",
        "https://static.scientificamerican.com/sciam/cache/file/F1E90F3D-1FFD-4BA9-9DFA98AE647FA7D4_source.jpg",
        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/close-up-of-cat-wearing-sunglasses-while-sitting-royalty-free-image-1571755145.jpg",
        "https://dcist.com/wp-content/uploads/sites/3/2019/04/Gem2-1500x1346.jpg"
        ]
    
    private var dogs : Array<UIImage> = Array<UIImage>()
    
    private let dogURLs : Array<String> = ["https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg",
        "https://images.fridaymagazine.ae/1_2307490/imagesList_0/2684410059_main.jpg",
        "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2019/02/dog-451643.jpg",
        "https://www.petmd.com/sites/default/files/styles/article_image/public/Dog-Tilting-Head.jpg",
        "https://cdn.britannica.com/48/167648-131-9CD98F23/Shiba-inu.jpg",
        "https://www.barringtonresidential.com/wp-content/uploads/2019/03/PET.jpg",
        "https://images6.fanpop.com/image/photos/41500000/it-s-national-dog-day-dogs-41538267-400-400.jpg",
        "https://s14.favim.com/orig/160219/cute-dog-puppy-Favim.com-4021434.jpg",
        "https://www.thesprucepets.com/thmb/AeTBqZb9qbdWZ_LR_qGOwoXNtFg=/1396x1396/smart/filters:no_upscale()/portrait-if-a-spitz-pomeranian_t20_v3o29E-5ae9bbdca18d9e0037d95983.jpg"
        ]
    
    private func addCats() {
        for cat in catURLs {
            self.downloadData(from: cat){ (imageData) in
                if let data = imageData {
                    DispatchQueue.main.async {
                        self.cats.insert(UIImage(data: data)!, at: 0)
                        if self.currentState == state.cats {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    private func addDogs() {
        for dog in dogURLs {
            self.downloadData(from: dog){ (imageData) in
                if let data = imageData {
                    DispatchQueue.main.async {
                        self.dogs.insert(UIImage(data: data)!, at: 0)
                        if self.currentState == state.dogs {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
 
    
    enum state {
        case cats
        case dogs
    }
    
    private var currentState = state.cats
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.buttonDogs.tintColor = UIColor.black
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  
        self.buttonDogs.addTarget(self, action: #selector(btDogsClicked), for: .touchDown)
        self.buttonCats.addTarget(self, action: #selector(btCatsClicked), for: .touchDown)
        
        addCats()
        addDogs()
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.48,
                      height: collectionView.frame.width*0.48)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentState {
        case state.cats:
            return self.cats.count
        case state.dogs:
            return self.dogs.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ImageViewCell

        switch currentState {
        case state.cats:
            cell.setImage(self.cats[indexPath.item])
        case state.dogs:
            cell.setImage(self.dogs[indexPath.item])
        }

        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 18

        UIView.animate(withDuration: 1, animations: {
            AnimationEngine.slide(cell, Double(indexPath.item)*0.15)
        })

       return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let detailView:DetailViewController = DetailViewController(frame: CGRect(x: 0, y: 0,
                                                                   width: self.view.frame.width,
                                                                   height: self.view.frame.height))
        switch currentState {
            case state.cats:
                detailView.setImage(self.cats[indexPath.row])
            case state.dogs:
                detailView.setImage(self.dogs[indexPath.row])
        }
        
        detailView.modalTransitionStyle = .crossDissolve
        detailView.modalPresentationStyle = .overFullScreen
        self.present(detailView, animated: true, completion: nil)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
