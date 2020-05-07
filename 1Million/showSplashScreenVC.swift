//
//  showSplashScreenVC.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

extension UIView {
    @IBInspectable var corner:CGFloat {
        set{
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var border_width:CGFloat {
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    
    @IBInspectable var border_color:UIColor? {
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
        get{
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }
}

class showSplashScreenVC: UIViewController {

    @IBOutlet weak var videoView: UIView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
          
          
//        if #available(iOS 13.0, *) {
//            overrideUserInterfaceStyle = .dark
//        }
       
        perform(#selector(showNavController), with: nil, afterDelay: 5)
         setupView()
    }
    
    private func setupView(){
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "videoSplash", ofType: "mp4")!)
        let player = AVPlayer(url: path)
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        player.play()
    }
    
    @objc func showNavController () {
        
        if let token = UserDefaults.standard.object(forKey: "token") as? String {
                                 
                               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                     self.present(nextViewController, animated:true, completion:nil)
                                 
        }else {
            
             performSegue(withIdentifier: "showSplashScreen", sender: self)
            
        }
              
              
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
