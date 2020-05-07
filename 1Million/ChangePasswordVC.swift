//
//  ChangePasswordVC.swift
//  1Million
//
//  Created by Ahmed on 2/5/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var activtyInd: UIActivityIndicatorView!
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmNewPassword: UITextField!
    @IBOutlet weak var btnSaveOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activtyInd.isHidden = true
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        
        txtCurrentPassword.layer.cornerRadius = 25.0
        txtCurrentPassword.layer.masksToBounds = true
        txtCurrentPassword.setLeftPaddingPoints(8)
        txtCurrentPassword.setRightPaddingPoints(8)
        
        txtNewPassword.layer.cornerRadius = 25.0
        txtNewPassword.layer.masksToBounds = true
        txtNewPassword.setLeftPaddingPoints(8)
        txtNewPassword.setRightPaddingPoints(8)
        
        txtConfirmNewPassword.layer.cornerRadius = 25.0
        txtConfirmNewPassword.layer.masksToBounds = true
        txtConfirmNewPassword.setLeftPaddingPoints(8)
        txtConfirmNewPassword.setRightPaddingPoints(8)
        
        btnSaveOutlet.layer.cornerRadius = 25.0
        btnSaveOutlet.layer.masksToBounds = true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
       
        if ((txtCurrentPassword.text?.isEmpty)! || (txtNewPassword.text?.isEmpty)! || (txtConfirmNewPassword.text?.isEmpty)!)  {
            let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال كافة بياناتك", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        } else if (txtNewPassword.text != txtConfirmNewPassword.text) {
           
            let alert = UIAlertController(title: "تنبيه !", message: "كلمات السر غير متطابقة", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
            
        } else {
            ChangePassword()
             activtyInd.isHidden = false
             activtyInd.startAnimating()
             btnSaveOutlet.isEnabled = false
             btnSaveOutlet.backgroundColor = UIColor.gray
        }
        
    }
}


extension ChangePasswordVC {
    
    func ChangePassword(){

                          let url = "https://1millioneg.com/api/user/update/password"
                
          
          guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
              
              
              return
          }
                
                let param = [
                
                    "old_password" : txtCurrentPassword.text! ,
                    "password" : txtNewPassword.text! ,
                    "password_confirmation" : txtConfirmNewPassword.text! ,
                  
                
                ]
          
          let header = [
          
              
              "Authorization" : "Bearer \(token)"
          
          ]
                                 
          Alamofire.request(url, method: .post, parameters: param , headers : header)
                                     .responseJSON { response in
                                         
                                      print(response.result)
                                      
                                      
                                      var Response = response.result.value as? NSDictionary
                                      print(Response)
                                      
                                      
                                        self.activtyInd.stopAnimating()
                                        self.btnSaveOutlet.isEnabled = false
                                        
                                         if response.result.isSuccess {
                                      
                  
                                             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                                                    self.present(nextViewController, animated:true, completion:nil)
                                             
                                         }else {
                                             
                                             
                                             print("error")
                                                                 
                                        let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال بياناتك الصحيحة", preferredStyle: .alert)
                                         let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                                         alert.addAction(okAction)
                                         self.btnSaveOutlet.isEnabled = true
                                         self.btnSaveOutlet.backgroundColor = #colorLiteral(red: 0.8928823471, green: 0.2479706109, blue: 0.1964860559, alpha: 1)
                                         self.activtyInd.isHidden = true
                                         self.activtyInd.stopAnimating()
                                         self.present(alert, animated: true, completion: nil)
                                             
                                         }
                                     
                                 }
                             }
                
         

    
    
}
