//
//  StampCollectionViewCell.swift
//  LineUI
//
//  Created by takuya on 2016/09/15.
//  Copyright © 2016年 takuya. All rights reserved.
//

import UIKit

final class StampCollectionViewCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
