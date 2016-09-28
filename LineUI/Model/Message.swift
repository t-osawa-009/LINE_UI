//
//  Message.swift
//  LineUI
//
//  Created by takuya on 2016/09/29.
//  Copyright © 2016年 takuya. All rights reserved.
//

import Foundation

enum MessageType {
    case text
    case image
}

struct Message {
    let type: MessageType
    let text: String
    let creatAt: Date
    let isReceived: Bool
    
    
    init(_ type: MessageType, text: String, creatAt: Date, isReceived: Bool) {
        self.type = type
        self.text = text
        self.creatAt = creatAt
        self.isReceived = isReceived
    }
}
