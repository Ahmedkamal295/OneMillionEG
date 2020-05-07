//
//  NotificationVC.swift
//  1Million
//
//  Created by Ahmed on 3/30/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var img =     [UIImage(named: "OM"),
                   UIImage(named: "OM"),
                   UIImage(named: "OM"),
                   UIImage(named: "OM"),
                   UIImage(named: "OM"),
                   UIImage(named: "OM"),
                   UIImage(named: "OM")]
    
    var lbl = [("Notification 1"),("Notification 1"),("Notification 1"),("Notification 1"),("Notification 1"),("Notification 1"),("Notification 1"),]
    
     var lbl2 = [("12-12-2020"),("12-12-2020"),("12-12-2020"),("12-12-2020"),("12-12-2020"),("12-12-2020"),("12-12-2020"),("12-12-2020"),]
    
     var lbl3 = [("In publishing graphic design, lorem ipsum is a placeholder text commonly used to flinfolling design, lorem ipsum is a placeholder text commonly used to flinfolling you comment"),("In publishing graphic design, lorem ipsum is a placeholder text commonly used to flinfolling design, lorem ipsum is a placeholder text commonly used to flinfolling you comment"),("In publishing graphic design, lorem ipsum is a placeholder text commonly used to flinfolling design, lorem ipsum is a placeholder text commonly used to flinfolling you comment"),("In publishing graphic design, lorem ipsum is a placeholder text commonly used to flinfolling design, lorem ipsum is a placeholder text commonly used to flinfolling you comment"),("In publishing graphic design, lorem ipsum is a placeholder text commonly used to flinfolling design, lorem ipsum is a placeholder text commonly used to flinfolling you comment"),("In publishing graphic design, lorem ipsum is a placeholder text commonly used to flinfolling design, lorem ipsum is a placeholder text commonly used to flinfolling you comment"),("In publishing graphic design, lorem ipsum is a placeholder text commonly used to flinfolling design, lorem ipsum is a placeholder text commonly used to flinfolling you comment"),]
    override func viewDidLoad() {
           super.viewDidLoad()
           
           tableView.tableFooterView = UIView()
           
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 150
               
           }
           
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return lbl.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellNotification
        cell?.lblNotification.text = lbl[indexPath.row]
        cell?.lblDate.text = lbl2[indexPath.row]
        cell?.lblText.text = lbl3[indexPath.row]
        cell?.img.image = img[indexPath.row]
           cell?.index = indexPath
           cell?.delegate = self
           return cell!
       }
       
      @IBAction func BtnBack(_ sender: Any) {
         let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
               self.navigationController?.pushViewController(vc!, animated: true)
         }
      
       }

  
extension NotificationVC: CellNotificationProtocol {
    func alertData(indx: Int) {
        
        let alert = UIAlertController(title: "تنبيه !", message: "👇 😛", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
            alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
        
//        img.remove(at: indx)
//        lbl.remove(at: indx)
//        tableView.reloadData()
    }
}
