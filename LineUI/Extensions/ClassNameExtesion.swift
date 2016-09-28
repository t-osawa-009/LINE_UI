//
//  ClassNameExtesion.swift
//  LineUI
//
//  Created by takuya on 2016/09/28.
//  Copyright © 2016年 takuya. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}
