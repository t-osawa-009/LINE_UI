//
//  ChatCollectionViewCell.swift
//  LineUI
//
//  Created by takuya on 2016/09/29.
//  Copyright © 2016年 takuya. All rights reserved.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    static let maxWidth = 110.0
    class func height(textHeight: CGFloat) -> CGFloat {
        let margin: CGFloat = 40.0
        return textHeight + margin
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ballonLabel.text = nil
    }
    
    var ballonText: String = "" {
        didSet {
            ballonLabel.text = ballonText
            layoutIfNeeded()
            setNeedsLayout()
        }
    }
    
    @IBOutlet private weak var ballonView: UIView!
    @IBOutlet private weak var ballonLabel: UILabel! {
        didSet {
           
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ballonView.layer.cornerRadius = ballonView.bounds.height / 2
    }
}
