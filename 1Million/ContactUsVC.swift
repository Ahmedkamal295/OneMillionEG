//
//  ContactUsVC.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class ContactUsVC: UIViewController {

    @IBOutlet weak var activtyInd: UIActivityIndicatorView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtMessageTittle: UITextField!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSendOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activtyInd.isHidden = true
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        
        txtFullName.layer.cornerRadius = 25.0
        txtFullName.layer.masksToBounds = true
        txtFullName.setLeftPaddingPoints(8)
        txtFullName.setRightPaddingPoints(8)
        
        txtPhoneNumber.layer.cornerRadius = 25.0
        txtPhoneNumber.layer.masksToBounds = true
        txtPhoneNumber.setLeftPaddingPoints(8)
        txtPhoneNumber.setRightPaddingPoints(8)
        
        txtMessageTittle.layer.cornerRadius = 25.0
        txtMessageTittle.layer.masksToBounds = true
        txtMessageTittle.setLeftPaddingPoints(8)
        txtMessageTittle.setRightPaddingPoints(8)
        
        txtMessage.layer.cornerRadius = 25.0
        txtMessage.layer.masksToBounds = true
        txtMessage.setLeftPaddingPoints(8)
        txtMessage.setRightPaddingPoints(8)
        
        btnSendOutlet.layer.cornerRadius = 25.0
        btnSendOutlet.layer.masksToBounds = true
    }
    
    @IBAction func btnSend(_ sender: Any) {
        if ((txtFullName.text?.isEmpty)! || (txtPhoneNumber.text?.isEmpty)! || (txtMessageTittle.text?.isEmpty)! || (txtMessage.text?.isEmpty)!) {
            let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال كافة البيانات", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        } else if (txtPhoneNumber.text!.count < 11) {
            let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال رقم الهاتف الصحيح", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            send()
            activtyInd.isHidden = false
            activtyInd.startAnimating()
            btnSendOutlet.isEnabled = false
            btnSendOutlet.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func send() {
        
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
                  return
              }
        let txtFullNameend = txtFullName.text!
        let txtPhoneNumberend = txtPhoneNumber.text!
        let txtYourEmailend = txtMessageTittle.text!
        let txtSubjectend = txtMessage.text!
        
        let sendurl = "https://1millioneg.com/api/customer-service"
        let parameters = [
            "name" : txtFullNameend,
            "mobile" : txtPhoneNumberend,
            "title" : txtYourEmailend,
            "message" : txtSubjectend,
        ]
        let header = [
               
                   
                   "Authorization" : "Bearer \(token)"
               
               ]
        Alamofire.request(sendurl, method: .post,parameters: parameters,headers: header)
            .responseJSON { response in
                let result = response.result
                print("the response is 1 : \(result)")
                print(parameters)
            
                self.activtyInd.stopAnimating()
                self.btnSendOutlet.isEnabled = false
                if (result.value as? Dictionary<String, AnyObject>) != nil {
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    self.present(nextViewController, animated:true, completion:nil)
                } else {
                    let alert = UIAlertController(title: "تنبيه !", message: "برجاء ادخال بياناتك الصحيحة", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.btnSendOutlet.isEnabled = true
                    self.btnSendOutlet.backgroundColor = #colorLiteral(red: 0.8928823471, green: 0.2479706109, blue: 0.1964860559, alpha: 1)
                    self.activtyInd.isHidden = true
                    self.activtyInd.stopAnimating()
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
}
