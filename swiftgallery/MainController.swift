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
    
    private func downloadData(fromURLString urlString: String,
                               completion: @escaping (Result<Data, Error>) -> Void)  {
        if let url = URL(string: urlString) {
            let urlSession = URLSession.shared.dataTask(with: url) { [] (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                }
            }

            urlSession.resume()
        }
    }

    private func parseDogJson(jsonData: Data) ->String {
        var result : String = String()
        
        do {
            let decodedData = try JSONDecoder().decode(DogJson.self, from: jsonData)
            result = decodedData.message
        } catch {
            print("decode error")
        }
        
        return result
    }
    
    @objc func btDogsClicked() {
        self.buttonDogs.tintColor = UIColor.systemBlue
        self.buttonCats.tintColor = UIColor.black
        
        items = dogs
        collectionView.reloadData()
        
    }
    
    @objc func btCatsClicked() {
        self.buttonDogs.tintColor = UIColor.black
        self.buttonCats.tintColor = UIColor.systemBlue
        
        items = cats
        collectionView.reloadData()
    }
    
    private let reuseIdentifier = "dataCell"
    
    private var cats : Array<UIImage> = Array<UIImage>()
    private var dogs : Array<UIImage> = Array<UIImage>()

    private var items : Array<UIImage> = Array<UIImage>()
    
    private func appendCat() {
        self.downloadData(fromURLString: "https://cataas.com/c") { (result) in
            switch result {
            case .success(let data):
                self.cats.append(UIImage(data: data)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func appendDog() {
        self.downloadData(fromURLString: "https://dog.ceo/api/breeds/image/random") { (result) in
            switch result {
            case .success(let data): do {
                self.downloadData(fromURLString: self.parseDogJson(jsonData: data)) { (result) in
                    switch result {
                    case .success(let data):
                        self.dogs.append(UIImage(data: data)!)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        for _ in 1...16 {
            appendCat()
            appendDog()
        }
        
        items = cats
        
        super.viewDidLoad()
        
        self.buttonDogs.tintColor = UIColor.black
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  
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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ImageViewCell
        
        cell.setImage(self.items[indexPath.item])

        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 18

        return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ImageViewCell
        
    }


    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ImageViewCell
        
    }

}
