//
//  IMUIEmojiModel.swift
//  sample
//
//  Created by oshumini on 2017/9/26.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
//表情类型
public enum IMUIEmojiType {
  case emoji
  case image
  case gif
}

public class IMUIEmojiModel: NSObject {
  var emojiType: IMUIEmojiType
  
  var emoji: String?
    //路径
  var mediaPath: String?
  
  public init(_ emojiType: IMUIEmojiType,
       _ emoji: String?,
       _ mediaPath: String?) {
    self.emojiType = emojiType
    self.emoji = emoji
    self.mediaPath = mediaPath
    super.init()
  }
  //便利构造函数
  convenience public init(emojiType: IMUIEmojiType,
                          emoji: String) {
    self.init(emojiType, emoji, nil)
  }
  
  convenience public init(emojiType: IMUIEmojiType,
                          mediaPath: String) {
    self.init(emojiType, nil, mediaPath)
  }
}
