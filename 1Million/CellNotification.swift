//
//  CellNotification.swift
//  1Million
//
//  Created by Ahmed on 3/30/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit
protocol CellNotificationProtocol {
    func alertData(indx: Int)
}
class CellNotification: UITableViewCell {

    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnAlert: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.cornerRadius = img.frame.size.width / 2
        img.clipsToBounds  = true
    }
    var delegate: CellNotificationProtocol?
       var index: IndexPath?
       
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnAlert(_ sender: Any) {
        delegate?.alertData(indx: (index?.row)!)
    }
    
}
