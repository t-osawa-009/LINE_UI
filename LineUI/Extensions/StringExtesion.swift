//
//  StringExtesion.swift
//  LineUI
//
//  Created by takuya on 2016/09/29.
//  Copyright © 2016年 takuya. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(CFloat.greatestFiniteMagnitude))
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
