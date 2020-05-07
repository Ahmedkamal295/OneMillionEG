//
//  RegisterVC.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import Photos
class RegisterVC: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
     var isActive:Bool = false
    
    @IBOutlet weak var activtyInd: UIActivityIndicatorView!
    @IBOutlet weak var txtIdNumber: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var btnImageView: UIView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRegisterOutlet: UIButton!
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnCheck: UIButton!
    var City = [CitiesModel]()
    
    var city_id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activtyInd.isHidden = true
        if let token = UserDefaults.standard.object(forKey: "token") as? String {
                        
                      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.present(nextViewController, animated:true, completion:nil)
                        
                    }
        
        
        getCitiesData()
        
        tblView.isHidden = true
       
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
            
        }
        
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        //
        txtIdNumber.layer.cornerRadius = 25.0
        txtIdNumber.layer.masksToBounds = true
        txtIdNumber.setLeftPaddingPoints(8)
        txtIdNumber.setRightPaddingPoints(8)
        
        txtFullName.layer.cornerRadius = 25.0
        txtFullName.layer.masksToBounds = true
        txtFullName.setLeftPaddingPoints(8)
        txtFullName.setRightPaddingPoints(8)
        
        btnImageView.layer.cornerRadius = 25.0
        btnImageView.layer.masksToBounds = true
        
        txtPhone.layer.cornerRadius = 25.0
        txtPhone.layer.masksToBounds = true
        txtPhone.setLeftPaddingPoints(8)
        txtPhone.setRightPaddingPoints(8)
        
        txtEmail.layer.cornerRadius = 25.0
        txtEmail.layer.masksToBounds = true
        txtEmail.setLeftPaddingPoints(8)
        txtEmail.setRightPaddingPoints(8)
        
        
        txtPasswordView.layer.cornerRadius = 25.0
        txtPasswordView.layer.masksToBounds = true
        
        btnRegisterOutlet.layer.cornerRadius = 25.0
        btnRegisterOutlet.layer.masksToBounds = true
    }
    
    @IBAction func btnCheck(_ sender: Any) {
        if isActive {
                  isActive = false
                  btnCheck.setImage(UIImage(named: "select1"), for: .normal)
              }else{
             
                  isActive = true
                  btnCheck.setImage(UIImage(named: "select2"), for: .normal)
              }
    }
    @IBOutlet weak var img: UIImageView!
    @IBAction func btnCamera(_ sender: Any) {
        
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
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnHidePassword(_ sender: Any) {
        if (txtPassword.isSecureTextEntry == false) {
            txtPassword.isSecureTextEntry = true
        } else {
            txtPassword.isSecureTextEntry = false
        }
    }
    
    
    @IBAction func btnRegister(_ sender: Any) {
  
        if ((txtIdNumber.text?.isEmpty)! || (txtFullName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtEmail.text?.isEmpty)! || (txtPassword.text?.isEmpty)!) {
                   let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال كافة بياناتك", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                   alert.addAction(okAction)
                   self.present(alert, animated: false, completion: nil)
            
             } else if ((txtIdNumber.text!.count < 14) || (txtIdNumber.text!.count > 14)) {

            let alert = UIAlertController(title: "تنبية", message: "ادخل الرقم القومي الصحيح", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
               alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
             } else if ((txtFullName.text!.count < 5)) {
            
            let alert = UIAlertController(title: "تنبية", message: "  الاسم اقل من ٥ احرف", preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                          alert.addAction(okAction)
                       self.present(alert, animated: true, completion: nil)
            
             } else if ((txtPhone.text!.count < 11) || (txtPhone.text!.count > 11)) {
            
            let alert = UIAlertController(title: "تنبية", message: "ادخل رقم الهاتف الصحيح", preferredStyle: .alert)
                                 let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                                    alert.addAction(okAction)
                                 self.present(alert, animated: true, completion: nil)
            
        } else if ((txtEmail.text!.contains("@") == false) || (txtEmail.text!.contains(".com") == false)) {
             
             let alert = UIAlertController(title: "تنبية", message: "برجاء ادخال البريد الالكتروني الصحيح", preferredStyle: .alert)
                                  let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                                     alert.addAction(okAction)
                                  self.present(alert, animated: true, completion: nil)
             // city metforspaed
            
        } else if (btnDrop.currentTitle == "المدينة" ) {
                       let alert = UIAlertController(title: "تنبية", message: "برجاء اختيار المدينة", preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                           alert.addAction(okAction)
                       self.present(alert, animated: true, completion: nil)
            
            
              } else if ((txtPassword.text!.count < 6)) {
            let alert = UIAlertController(title: "تنبية", message: "برجاء ادخال كلمة مرور صحيحة", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            } else {
                let alert = UIAlertController(title: "انتبة", message: "الموافقة علي شروط الاستخدام", preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: {
                           action in
                        self.SignUp()
                        self.btnRegisterOutlet.backgroundColor = UIColor.gray
                        self.btnRegisterOutlet.isEnabled = false
                        self.activtyInd.isHidden = false
                        self.activtyInd.startAnimating()
                       })
                       let cancelAction = UIAlertAction(title: "الغاء", style: .default, handler: nil)
                       alert.addAction(okAction)
                       alert.addAction(cancelAction)
                       self.present(alert, animated: true, completion: nil)
                   }
               }
               
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func onClickDropButton(_ sender: Any) {
        if tblView.isHidden {
            animate(toogle: true, type: btnDrop)
        } else {
            animate(toogle: false, type: btnDrop)
        }
        
        
    }
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
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
        img.image = selectedImage

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    // func animation tableView City in button
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
    

extension RegisterVC: UITableViewDelegate, UITableViewDataSource {
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

extension RegisterVC {
    func SignUp(){
    
        
        guard let city_id = city_id else { return
            
            // alert to choose city
            
        }
        
            let image1 = img.image
            let imageData1 =  image1?.jpegData(compressionQuality: 0.2)
            
        
            
            guard imageData1 != nil  else {
                
             
                // choose image
                return
            }
            
            
        print("----------------------------->",imageData1, "----------------------->")
            
            let url =  "https://1millioneg.com/api/auth/register"
          
        
        guard let name = txtFullName.text , !name.isEmpty ,
            let email = txtEmail.text ,
            let mobile = txtPhone.text ,
            let id_number = txtIdNumber.text ,
            let password = txtPassword.text else {
            
            
            // validation
            
            
            // all field ot complete
            
            return
        }
        

        
            
            let parameters = [
                
                "name" : name ,
                "email" : email ,
                "image" : "" ,
                "mobile" : mobile ,
                "city_id" : "\(city_id)" ,
                "password" : password ,
                "national_id" : id_number ,
              
                
              
         
               
                ]
            
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
                if imageData1 != nil {
                   
                    multipartFormData.append(imageData1!, withName: "national_id_image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
            }, to:"https://1millioneg.com/api/auth/register")
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
                            
                            
                            if let arrayOfDic = JSON as? Dictionary<String, AnyObject> {
                                
                            
                                guard  arrayOfDic["code"] as? Int == nil else {
                                    
                                    
                                    //alert
                                    
                                    print("error")
                                    return
                                }
                                
                                let userdata = arrayOfDic["meta"] as? Dictionary<String, AnyObject>
                                let token = userdata?["token"] as! String
                                let userdat = arrayOfDic["data"]
                                let id = userdat?["id"] as! Int
                                let mobile = userdat?["mobile"] as! String
                                let name = userdat?["name"] as! String
                                let email = userdat?["email"] as! String
                                let city = userdat?["city"] as! String
                                let national_id = userdat?["national_id"] as! String
                                
                                self.btnRegisterOutlet.isEnabled = false
                                self.activtyInd.stopAnimating()
                                print(token)
                                
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
                                
                                UserDefaults.standard.set(national_id, forKey: "national_id")
                                                       UserDefaults.standard.synchronize()
                                
                            
                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                                                  self.present(nextViewController, animated:true, completion:nil)
                        
                    }
                    
                        }
                    }
                    
                case .failure(let encodingError):
                    //self.delegate.showFailAlert()
                  
                    print(encodingError)
                }
                
        }
    }
}

extension RegisterVC {
    
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
       
    
}
