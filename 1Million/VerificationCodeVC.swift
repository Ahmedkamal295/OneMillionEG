//
//  VerificationCodeVC.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class VerificationCodeVC: UIViewController {
    
    @IBOutlet weak var activtyind: UIActivityIndicatorView!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var btnVerifyCodeOutlet: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activtyind.isHidden = true
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        
        txtCode.layer.cornerRadius = 25.0
        txtCode.layer.masksToBounds = true
        
        txtCode.setLeftPaddingPoints(8)
        txtCode.setRightPaddingPoints(8)
        
        btnVerifyCodeOutlet.layer.cornerRadius = 25.0
        btnVerifyCodeOutlet.layer.masksToBounds = true
        //
        txtPassword.layer.cornerRadius = 25.0
        txtPassword.layer.masksToBounds = true
        //
        txtConfirmPassword.layer.cornerRadius = 25.0
        txtConfirmPassword.layer.masksToBounds = true
    }
    
    @IBAction func btnHidePassword(_ sender: Any) {
        if (txtPassword.isSecureTextEntry == false) {
            txtPassword.isSecureTextEntry = true
        } else {
            txtPassword.isSecureTextEntry = false
        }
    }
    
    
    @IBAction func btnHideConfirm(_ sender: Any) {
        if (txtConfirmPassword.isSecureTextEntry == false) {
            txtConfirmPassword.isSecureTextEntry = true
        } else {
            txtConfirmPassword.isSecureTextEntry = false
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnVerifyCode(_ sender: Any) {
        
        if ((txtCode.text?.isEmpty)! || (txtPassword.text?.isEmpty)!) || (txtConfirmPassword.text?.isEmpty)! {
                  let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال كافة بياناتك", preferredStyle: .alert)
                  let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                  alert.addAction(okAction)
                  self.present(alert, animated: false, completion: nil)
        } else if (txtPassword.text != txtConfirmPassword.text) {
                 
            let alert = UIAlertController(title: "تنبيه !", message: "كلمات السر غير متطابقة", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
                        
                  
        } else {
            VerivicationCode()
            activtyind.isHidden = false
            activtyind.startAnimating()
            btnVerifyCodeOutlet.isEnabled = false
            btnVerifyCodeOutlet.backgroundColor = UIColor.gray
        }
          }
       
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension VerificationCodeVC {
    
    
    func VerivicationCode(){

                     let url = "https://1millioneg.com/api/resset-password"
           
           
           let param = [
           
               "code" : txtCode.text! ,
               "password" : txtPassword.text! ,
               "password_confirmation" : txtConfirmPassword.text!
           
           ]
                            
                            Alamofire.request(url, method: .post, parameters: param)
                                .responseJSON { response in
                                    
                                 print(response)
                                 var Response = response.result.value as? NSDictionary
                                 print(Response)
                                 
                                    self.btnVerifyCodeOutlet.isEnabled = false
                                    self.activtyind.startAnimating()
                                    if response.result.isSuccess {
                                 
             
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                                               self.present(nextViewController, animated:true, completion:nil)
                                        
                                    }else {
                                        
                                        
                                        print("error")
                                    let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال بياناتك الصحيحة", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                                    alert.addAction(okAction)
                                    self.btnVerifyCodeOutlet.isEnabled = true
                                    self.btnVerifyCodeOutlet.backgroundColor = #colorLiteral(red: 0.8928823471, green: 0.2479706109, blue: 0.1964860559, alpha: 1)
                                    self.activtyind.isHidden = true
                                    self.activtyind.stopAnimating()
                                    self.present(alert, animated: true, completion: nil)
                                        
                                    }
                                
                            }
                        }
           
    
}
