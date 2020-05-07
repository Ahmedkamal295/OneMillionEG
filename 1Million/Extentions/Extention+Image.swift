//
//  Extention+Image.swift
//  1Million
//
//  Created by Khaled Ghoniem on 2/23/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(_ url : URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
