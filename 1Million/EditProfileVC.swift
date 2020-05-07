//
//  EditProfileVC.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
    
    @IBOutlet weak var btnImgID: UIButton!
    @IBOutlet weak var imgID: UIImageView!
    @IBOutlet weak var lblIdImg: UILabel!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var activtyInd: UIActivityIndicatorView!
    @IBOutlet weak var btnChangePasswordOtlet: UIButton!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var type = 0
   
    @IBOutlet weak var btnEditOutlet: UIButton!

    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    
    var City = [CitiesModel]()
    
    var city_id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        activtyInd.isHidden = true
        getCitiesData()
        
        tblView.isHidden = true
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }

        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        
        lblIdImg.layer.cornerRadius = 25.0
        lblIdImg.layer.masksToBounds = true
        
        btnChangePasswordOtlet.layer.cornerRadius = 17.0
        btnChangePasswordOtlet.layer.masksToBounds = true
        
      
        
        txtFullName.text = UserDefaults.standard.object(forKey: "name") as? String
        txtPhone.text = UserDefaults.standard.object(forKey: "mobile") as? String
        txtEmail.text = UserDefaults.standard.object(forKey: "email") as? String
        btnDrop.setTitle(UserDefaults.standard.object(forKey: "city") as? String, for: .normal)
        imgID.image = UserDefaults.standard.object(forKey: "ImageId") as? UIImage
      
        txtFullName.layer.cornerRadius = 25.0
        txtFullName.layer.masksToBounds = true
        txtFullName.setLeftPaddingPoints(8)
        txtFullName.setRightPaddingPoints(8)

        txtPhone.layer.cornerRadius = 25.0
        txtPhone.layer.masksToBounds = true
        txtPhone.setLeftPaddingPoints(8)
        txtPhone.setRightPaddingPoints(8)

        txtEmail.layer.cornerRadius = 25.0
        txtEmail.layer.masksToBounds = true
        txtEmail.setLeftPaddingPoints(8)
        txtEmail.setRightPaddingPoints(8)

        btnDrop.layer.cornerRadius = 25.0
        btnDrop.layer.masksToBounds = true
       

        btnEditOutlet.layer.cornerRadius = 25.0
        btnEditOutlet.layer.masksToBounds = true
    }
    
    @IBAction func onClickDropButton(_ sender: Any) {
        if tblView.isHidden {
            animate(toogle: true, type: btnDrop)
        } else {
            animate(toogle: false, type: btnDrop)
        }
        
        
    }
    
    
    @IBAction func btnChangePassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        if ((txtFullName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtEmail.text?.isEmpty)!) {
                  let alert = UIAlertController(title: "Error", message: "please enter all of your information", preferredStyle: .alert)
                  let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                  alert.addAction(okAction)
                  self.present(alert, animated: false, completion: nil)
           
              } else {
                   UpdateProfile()
            activtyInd.isHidden = false
            activtyInd.startAnimating()
            btnEditOutlet.isEnabled = false
            btnEditOutlet.backgroundColor = UIColor.gray
              }
    }
    @IBAction func btnBack(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func btnCamera(_ sender: Any) {
        
        type = 0
        
        let actionSheet = UIAlertController(title : nil, message : nil, preferredStyle : .actionSheet)
                   actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert : UIAlertAction!) in
                       self.camera()
                   }))
                   
                   
                   actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert : UIAlertAction!) in
                       self.photoLibrary()
                   }))
                   
                   actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                   
                   self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func btnImgID(_ sender: Any) {
        
        type = 1
        
        let actionSheet = UIAlertController(title : nil, message : nil, preferredStyle : .actionSheet)
                          actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert : UIAlertAction!) in
                              self.camera()
                          }))
                          
                          
                          actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert : UIAlertAction!) in
                              self.photoLibrary()
                          }))
                          
                          actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                          
                          self.present(actionSheet, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    // btn Open Camera func
    func camera()
       {
           if UIImagePickerController.isSourceTypeAvailable(.camera)
           {
               let myPickerController = UIImagePickerController()
               myPickerController.delegate = self;
               myPickerController.sourceType = .camera
               self.present(myPickerController, animated : true, completion : nil)
               
           }
           else
           {
               let alert = UIAlertController(title: "Error", message: "camera not available", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
               alert.addAction(okAction)
               self.present(alert, animated: true, completion: nil)
               
               print("camera not available")
           }
       }
       func photoLibrary()
       {
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
           {
               let myPickerController = UIImagePickerController()
               myPickerController.delegate = self;
               myPickerController.sourceType = .photoLibrary
               self.present(myPickerController, animated : true, completion : nil)
               
           }
       }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        
        
        if type == 0 {
            
              imgProfile.image = selectedImage
            
        }else {
            
               imgID.image = selectedImage
             editeImageId()
        }
          
         
     
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
}




extension EditProfileVC {
    
    func UpdateProfile(){

                        let url = "https://1millioneg.com/api/user/update/info"
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            return
        }
        guard let city_id = city_id else { return
            
            // alert to choose city
            
        }
              
              let param = [
              
                "name" : txtFullName.text! ,
                "email" : txtEmail.text! ,
                "mobile" : txtPhone.text! ,
                "city_id" : "\(city_id)" ,
              
              ]
        
        let header = [
        
            
            "Authorization" : "Bearer \(token)"
        
        ]
                               
        Alamofire.request(url, method: .post, parameters: param , headers : header)
                                   .responseJSON { response in
                                       
                                    print(response.result)
                                    
                                    
                                    var Response = response.result.value as? NSDictionary
                                    print(Response)
                                    
                                    var userdat = Response?["data"] as? NSDictionary
                                  
                                    let mobile = userdat?["mobile"] as! String
                                    let name = userdat?["name"] as! String
                                    let email = userdat?["email"] as! String
                                    let city = userdat?["city"] as! String
                                    let imageId = userdat?["national_id_image"] as! String
                                 
                                    


                                 UserDefaults.standard.set(token, forKey: "token")
                                 UserDefaults.standard.synchronize()

                                UserDefaults.standard.set(name, forKey: "name")
                                UserDefaults.standard.synchronize()

                                UserDefaults.standard.set(mobile, forKey: "mobile")
                                UserDefaults.standard.synchronize()

                                UserDefaults.standard.set(email, forKey: "email")
                                UserDefaults.standard.synchronize()

                                UserDefaults.standard.set(city, forKey: "city")
                                UserDefaults.standard.synchronize()

                                UserDefaults.standard.set(imageId, forKey: "ImageId")
                                UserDefaults.standard.synchronize()
                           
                                 
                                                               
                                    self.activtyInd.stopAnimating()
                                    self.btnEditOutlet.isEnabled = false
                                       if response.result.isSuccess {
                                    
                
                                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                                                  self.present(nextViewController, animated:true, completion:nil)
                                           
                                       }else {
                                           
                                           
                                           print("error")
                                                               
                                    let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال بياناتك الصحيحة", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                                       alert.addAction(okAction)
                                    self.btnEditOutlet.isEnabled = true
                                    self.btnEditOutlet.backgroundColor = #colorLiteral(red: 0.8928823471, green: 0.2479706109, blue: 0.1964860559, alpha: 1)
                                    self.activtyInd.isHidden = true
                                    self.activtyInd.stopAnimating()
                                    self.present(alert, animated: true, completion: nil)
                                        
                                       }
                                   
                               }
                           }
    
    // func btnDrop
    func animate(toogle: Bool, type: UIButton) {
        
        if type == btnDrop {
            
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.tblView.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.tblView.isHidden = true
                }
            }
            
        }
    }
                    }


extension EditProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return City.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = City[indexPath.row].name
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle(City[indexPath.row].name, for: .normal)
        city_id = City[indexPath.row].id
        animate(toogle: false, type: btnDrop)
    }
    
    
}

extension EditProfileVC {
    
    func getCitiesData() {
        
        
        let url = "https://1millioneg.com/api/cities"
        
        Alamofire.request(url, method: .get, parameters: nil)
            .responseJSON { response in
                
                
                var Response = response.result.value as? NSDictionary
                print(Response)
                
                
                var data = Response?["data"] as? NSArray
                
                print(data!)
                
                for item in data ?? [] {
                    
                    
                    var data = item as? NSDictionary
                    
                    var id = data?["id"] as? Int
                    
                    var name = data?["name"] as? String
                    
                    
                    self.City.append(CitiesModel(id: id!, name: name!))
                    
                    
                    self.tblView.reloadData()
                    
                    
                }
                
              
        }
    }
    
    
    func editeImageId(){

          
    
          
          
              let image1 = imgID.image
              let imageData1 =  image1?.jpegData(compressionQuality: 0.2)
              
          
              
              guard imageData1 != nil  else {
                  
               
                  // choose image
                  return
              }
              
  

          
              
              let parameters = [
                  
                String : String
           
                 
                  ]()
              
              
              
              Alamofire.upload(multipartFormData: { (multipartFormData) in
                  for (key, value) in parameters {
                      multipartFormData.append(value.data(using: .utf8)!, withName: key)
                  }
                  if imageData1 != nil {
                     
                      multipartFormData.append(imageData1!, withName: "national_id_image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                  }
                  
              }, to:"https://1millioneg.com/api/user/update/national-id-image")
              { (result) in
                  
                  print(result)
                  switch result {
                  case .success(let upload, _, _):
                      
                      upload.uploadProgress(closure: { (Progress) in
                          print("Upload Progress: \(Progress.fractionCompleted)")
                      })
                      
                      upload.responseJSON { response in
                        
                          if let JSON = response.result.value as? [String : Any] {
                              
                              
                              
                              print("JSON: \(JSON)")
                              
                        }
                      }
                      
                  case .failure(let encodingError):
                      //self.delegate?.showFailAlert()
                    
                      print(encodingError)
                  }
                  
          }
        
    }
    
}
