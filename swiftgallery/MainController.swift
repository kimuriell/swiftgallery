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
    
    struct DogJson: Codable {
        let message: String
        let status: String
    }
    
    struct CatJson: Codable {
        let file: String
    }
    
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

    private func parseDogJson(jsonData: Data) ->String {
        var result : String = String()
        
        do {
            let decodedData = try JSONDecoder().decode(DogJson.self, from: jsonData)
            result = decodedData.message
        } catch {}
        
        return result
    }
    
    private func parseCatJson(jsonData: Data) ->String {
        var result : String = String()
        
        do {
            let decodedData = try JSONDecoder().decode(CatJson.self, from: jsonData)
            result = decodedData.file
        } catch {}
        
        return result
    }
    
    @objc func btDogsClicked() {
        self.buttonDogs.tintColor = UIColor.systemBlue
        self.buttonCats.tintColor = UIColor.black
        
        if self.currentState == state.dogs {
          //  return
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
    private var dogs : Array<UIImage> = Array<UIImage>()
    
    private func appendCat() {
        self.downloadData(from: "https://aws.random.cat/meow"){ (imageUrl) in
            if let data = imageUrl {
                DispatchQueue.main.async {
                    self.downloadData(from: self.parseCatJson(jsonData: data)){ (imageData) in
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
        }
    }
    
    private func appendDog() {
        self.downloadData(from: "https://dog.ceo/api/breeds/image/random"){ (imageUrl) in
            if let data = imageUrl {
                DispatchQueue.main.async {
                    self.downloadData(from: self.parseDogJson(jsonData: data)){ (imageData) in
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
        
        
        for _ in 1...3 {
            appendCat()
        }
        
        for _ in 1...7 {
            appendDog()
        }

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
//        let cell = collectionView.cellForItem(at: indexPath) as! ImageViewCell
        
    }


    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ImageViewCell
        
    }
}
