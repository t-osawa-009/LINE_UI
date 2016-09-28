//
//  ChatCollectionView.swift
//  LineUI
//
//  Created by takuya on 2016/09/29.
//  Copyright © 2016年 takuya. All rights reserved.
//

import Foundation
import UIKit

protocol ChatCollectionViewDataSource {
    func numberOfItemsInSection() -> Int
    func cellForItemAt(_ indexPath: IndexPath) -> Message
}

final class ChatCollectionView: UICollectionView {
    var chatDataSource: ChatCollectionViewDataSource?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        register(cellType: ChatCollectionViewCell.self)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionViewLayout = flowLayout
        alwaysBounceVertical = true
    }
}

extension ChatCollectionView: UICollectionViewDelegate {
    
}

extension ChatCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatDataSource?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ChatCollectionViewCell.self, for: indexPath)
        if let message = chatDataSource?.cellForItemAt(indexPath) {
            cell.ballonText = message.text
        }
        return cell
    }
}

extension ChatCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        if let message = chatDataSource?.cellForItemAt(indexPath) {
            let textHeight = message.text.heightWithConstrainedWidth(width: CGFloat(ChatCollectionViewCell.maxWidth), font: UIFont.systemFont(ofSize: 17))
            return CGSize(width: width, height: ChatCollectionViewCell.height(textHeight: textHeight))
        } else {
            let textHeight = "".heightWithConstrainedWidth(width: CGFloat(ChatCollectionViewCell.maxWidth), font: UIFont.systemFont(ofSize: 17))
            return CGSize(width: width, height: ChatCollectionViewCell.height(textHeight: textHeight))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
