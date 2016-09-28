//
//  StampViewController.swift
//  LineUI
//
//  Created by takuya on 2016/09/28.
//  Copyright © 2016年 takuya. All rights reserved.
//

import Foundation
import UIKit

final class StampViewController: UIViewController {
    fileprivate let padding: CGFloat = 5.0
    var pageNumber = 0
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(cellType: StampCollectionViewCell.self)
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            collectionView.collectionViewLayout = flowLayout
            collectionView.alwaysBounceVertical = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension StampViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: StampCollectionViewCell.self, for: indexPath)
            cell.imageView.image = Constants.icons[pageNumber]
        return cell
    }
}

extension StampViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension StampViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let photoCountPerRow = 4
        let photoWidth = (width - CGFloat(photoCountPerRow - 1) * padding) / CGFloat(photoCountPerRow)
        return CGSize(width: photoWidth, height: photoWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
