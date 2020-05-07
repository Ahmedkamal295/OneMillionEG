//
//  ProfileVC.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
   
    @IBOutlet weak var txtUserName: UILabel!
    @IBOutlet weak var txtIdUser: UILabel!
    @IBOutlet weak var txtPhoneNumber: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtCity: UILabel!
    @IBOutlet weak var btnSubmitOutlet: UIButton!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var idNumberView: UIView!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var cityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        
        txtUserName.text = UserDefaults.standard.object(forKey: "name") as? String
        txtIdUser.text = UserDefaults.standard.object(forKey: "national_id") as? String
        txtPhoneNumber.text = UserDefaults.standard.object(forKey: "mobile") as? String
        txtEmail.text = UserDefaults.standard.object(forKey: "email") as? String
        txtCity.text = UserDefaults.standard.object(forKey: "city") as? String
      
        
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        
        btnSubmitOutlet.layer.cornerRadius = 25.0
        btnSubmitOutlet.layer.masksToBounds = true
        
        userNameView.layer.cornerRadius = 25.0
        userNameView.layer.masksToBounds = true
        
        idNumberView.layer.cornerRadius = 25.0
        idNumberView.layer.masksToBounds = true
        
        mobileNumberView.layer.cornerRadius = 25.0
        mobileNumberView.layer.masksToBounds = true
        
        emailView.layer.cornerRadius = 25.0
        emailView.layer.masksToBounds = true
        
        cityView.layer.cornerRadius = 25.0
        cityView.layer.masksToBounds = true
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func btnEdit(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.present(nextViewController, animated:true, completion:nil)
    }
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    }


