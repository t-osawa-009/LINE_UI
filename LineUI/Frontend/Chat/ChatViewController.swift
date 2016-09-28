//
//  ChatViewController.swift
//  LineUI
//
//  Created by takuya on 2016/09/15.
//  Copyright © 2016年 takuya. All rights reserved.
//

import Foundation
import UIKit

final class ChatViewController: UIViewController {
    @IBOutlet fileprivate weak var chatCollectionView: ChatCollectionView! {
        didSet {
            chatCollectionView.chatDataSource = self
        }
    }
    @IBOutlet private weak var inputTextView: UIView!
    @IBOutlet private weak var keyBoardView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var keyBoardHeightConstraint: NSLayoutConstraint!
    fileprivate let padding: CGFloat = 5.0
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(cellType: StampCollectionViewCell.self)
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = flowLayout
            collectionView.alwaysBounceVertical = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    var pageViewController: UIPageViewController?
    var stampViewControllers = [StampViewController]()
    fileprivate var messages: [Message] = [
    ]
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputTextView.transform = CGAffineTransform(translationX: 0, y: self.keyBoardHeightConstraint.constant)
        self.keyBoardView.transform = CGAffineTransform(translationX: 0, y: self.keyBoardHeightConstraint.constant)
        
        for index in 0...9 {
            let viewController = StampViewController.instantiate()
            viewController.pageNumber = index
            stampViewControllers.append(viewController)
        }
        
        pageViewController = childViewControllers[0] as? UIPageViewController
        pageViewController!.dataSource = self
        pageViewController!.setViewControllers([stampViewControllers[0]], direction: .forward, animated: false, completion: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chatCollectionViewTapped(sender:)))
        chatCollectionView.addGestureRecognizer(tapGesture)
    }
    
    func showKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo{
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                let keyBoardRect = keyboard.cgRectValue
                keyBoardHeightConstraint.constant = keyBoardRect.height
                showKeyboard()
            }
        }
    }
    
    fileprivate func showKeyboard() {
        UIView.animate(withDuration: 0.3) {
            self.inputTextView.transform = CGAffineTransform.identity
            self.keyBoardView.transform = CGAffineTransform.identity
        }
    }
    
    fileprivate func hiddenKeyboard() {
        UIView.animate(withDuration: 0.3) {
            self.inputTextView.transform = CGAffineTransform(translationX: 0, y: self.keyBoardHeightConstraint.constant)
            self.keyBoardView.transform = CGAffineTransform(translationX: 0, y: self.keyBoardHeightConstraint.constant)
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: AnyObject) {
        guard let inputText = textField.text else {
            return
        }
        
        guard inputText.characters.count > 2 && !inputText.isEmpty else {
            return
        }
        
        let message = Message(.text, text: inputText, creatAt: Date(), isReceived: false)
        messages.append(message)
        textField.text = ""
        chatCollectionView.reloadData()
    }
    
    @IBAction func stampButtonTapped(_ sender: AnyObject) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        showKeyboard()
    }
    
    func chatCollectionViewTapped(sender: UITapGestureRecognizer) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
            hiddenKeyboard()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
            hiddenKeyboard()
        }
    }
}

extension ChatViewController: UIPageViewControllerDataSource {
    // 逆方向にページ送りした時に呼ばれるメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = stampViewControllers.index(of: viewController as! StampViewController) , index > 0 else {
            return nil
        }
        
        return stampViewControllers[index - 1]
    }
    
    // 順方向にページ送りした時に呼ばれるメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = stampViewControllers.index(of: viewController as! StampViewController) , index < stampViewControllers.count - 1 else {
            return nil
        }
        
        return stampViewControllers[index + 1]
    }
}

extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: StampCollectionViewCell.self, for: indexPath)
        cell.imageView.image = #imageLiteral(resourceName: "warai_flat")
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ChatViewController: ChatCollectionViewDataSource {
    func numberOfItemsInSection() -> Int {
        return messages.count
    }
    
    func cellForItemAt(_ indexPath: IndexPath) -> Message {
        return messages[indexPath.item]
    }
}
