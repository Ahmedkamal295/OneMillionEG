//
//  ViewController.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    @IBOutlet weak var activtyInd: UIActivityIndicatorView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
     @IBOutlet weak var pageView: UIPageControl!
   
    @IBOutlet weak var btnLog: UIButton!
    
     var imgArr = [sliderImagesModel]()
   
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSliderImages()
        
        activtyInd.startAnimating()
                if #available(iOS 13.0, *) {
                    overrideUserInterfaceStyle = .dark
                }
       
                pageView.numberOfPages = imgArr.count
                pageView.currentPage = 0
       

        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func btnLog(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.present(nextViewController, animated:true, completion:nil)
  }
    @objc func changeImage() {
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter

            counter = 1
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell
        if let vc = cell?.viewWithTag(111) as? UIImageView {
           var imageUrl = imgArr[indexPath.row].image ?? ""
            cell?.img.loadImage(URL(string: imageUrl))
                  
        }
        
        return cell!
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController {
    
     func getSliderImages() {
              
            let url = "https://1millioneg.com/api/ads"
                   
                   Alamofire.request(url, method: .get, parameters: nil)
                       .responseJSON { response in
                          
                        var Response = response.result.value as? NSDictionary
                        print(Response)
                        
                        
                        var data = Response?["data"] as? NSArray
                        
                                        
                        for item in data ?? [] {
                            
                            
                            var data = item as? NSDictionary
                            
                            var id = data?["id"] as? Int
                            
                            var name = data?["name"] as? String
                            
                            var image = data?["image"] as? String
                            
                            self.imgArr.append(sliderImagesModel(id: id, name: name, image: image))
                            
                           
                            self.sliderCollectionView.reloadData()
                            self.activtyInd.stopAnimating()
                            self.activtyInd.isHidden = true
                        }
                        
                        
                   }
               }
           
       
}


