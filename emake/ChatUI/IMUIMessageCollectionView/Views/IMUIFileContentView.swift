//
//  IMUIFileContentView.swift
//  emake
//
//  Created by 张士超 on 2018/5/28.
//  Copyright © 2018年 emake. All rights reserved.
//

import UIKit

class IMUIFileContentView: UIView ,IMUIMessageContentViewProtocol{

    var imageView = UIImageView()
    var fileName = UILabel()
    var fileSize = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.image = UIImage.init(named: "wenjian")
        self.addSubview(imageView)
        self.addSubview(fileName)
        self.addSubview(fileSize)
        fileName.numberOfLines = 1
        imageView.contentMode = .scaleAspectFit
    }
    required public init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    public func layoutContentView(message: IMUIMessageModelProtocol) {
        
        imageView.frame = CGRect(x: 9, y:7, width: 42, height:42)
        fileName.font = UIFont.systemFont(ofSize: 14)
        fileName.frame = CGRect(x: 55, y:7, width: 160, height:20)
        fileSize.frame = CGRect(x: 55, y:30, width: 160, height:20)
        fileName.font = UIFont.systemFont(ofSize: 16)
        fileSize.font = UIFont.systemFont(ofSize: 14)
        if message.isOutGoing {
            fileName.textColor = UIColor.white
        }else{
            fileName.textColor = UIColor.black
        }
        let model = YHFileModel.mj_object(withKeyValues: message.text())
        
        fileName.text = model?.fileName
        fileSize.text = model?.fileSize

    }

}
