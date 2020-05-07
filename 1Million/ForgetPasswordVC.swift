//
//  ForgetPasswordVC.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var activtyInd: UIActivityIndicatorView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnGetCodeOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activtyInd.isHidden = true
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        
        txtEmail.layer.cornerRadius = 25.0
        txtEmail.layer.masksToBounds = true
        txtEmail.setLeftPaddingPoints(8)
        txtEmail.setRightPaddingPoints(8)
        
        btnGetCodeOutlet.layer.cornerRadius = 25.0
        btnGetCodeOutlet.layer.masksToBounds = true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnGetCode(_ sender: Any) {
        
        guard let email = txtEmail.text else {
                   
                   // email is not valide
                   return
               }
        if ((txtEmail.text?.isEmpty)!) {
                          let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال كافة بياناتك", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: false, completion: nil)
                  
                     } else {
            
                         ForgetPassword()
            
                         btnGetCodeOutlet.isEnabled = false
                         btnGetCodeOutlet.backgroundColor = UIColor.gray
                         activtyInd.isHidden = false
                         activtyInd.startAnimating()
                     }
           }
        
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension ForgetPasswordVC {
    func ForgetPassword() {

                  let url = "https://1millioneg.com/api/send-resset-email"
        
        
        let param = [
        
            "email" : txtEmail.text!
        
                      ]
                         
                         Alamofire.request(url, method: .post, parameters: param)
                             .responseJSON { response in
                                
                              print(response)
                              var Response = response.result.value as? NSDictionary
                              print(Response)
                              
                              
                              var data = Response?["data"] as? NSDictionary
                              
                
                              var code = data?["code"] as? Int ?? 0
                                
                                self.btnGetCodeOutlet.isEnabled = false
                                self.activtyInd.startAnimating()
                                if code == 200 {
                                    
                                    print("sccess")
                                    
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
                                          self.present(nextViewController, animated:true, completion:nil)
                                    
                                }else {
                                    
                                    print("error")
                                    let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال البريد الالكترونى الصحيح", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                                    alert.addAction(okAction)
                                    self.btnGetCodeOutlet.isEnabled = true
                                    self.btnGetCodeOutlet.backgroundColor = #colorLiteral(red: 0.8928823471, green: 0.2479706109, blue: 0.1964860559, alpha: 1)
                                    self.activtyInd.isHidden = true
                                    self.activtyInd.stopAnimating()
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                                

                         }
                     }
    
}
