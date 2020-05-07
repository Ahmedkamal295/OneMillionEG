//
//  Cell.swift
//  1Million
//
//  Created by Ahmed on 2/20/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
protocol CellProtocol {
    func goCell(indx: Int)
}
class Cell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    var isActive:Bool = false
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
//    var delegate: CellProtocol?
//    var index: IndexPath?
//
//    @IBAction func btnLog(_ sender: UIButton) {
//        delegate?.goCell(indx: (index?.row)!)
//    }
   
    
    
}
