//
//  IMUIGalleryDataManager.swift
//  IMUIChat
//
//  Created by oshumini on 2017/3/9.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import Photos
//图片管理类
class IMUIGalleryDataManager: NSObject {
        //最多选择张数
  static var maxSeletedCount = 6
  // 目标尺寸
  static var targetSize = CGSize(width: 200, height: 200)
  
  private static var _allAssets = [PHAsset]()
  static var allAssets : [PHAsset] {
    get {
      if _allAssets.count < 1 {
        updateAssets()
      }
      
      return _allAssets
    }
  }
  
  class func updateAssets(){
    //取操作
    let options = PHFetchOptions()
    //清空
    _allAssets.removeAll()
    //排序时间降序排列
    options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    //从相册取出
    let assetFetchResult = PHAsset.fetchAssets(with: options)
    //选出其中的图片
    assetFetchResult.enumerateObjects({(asset, _, _) in
      if asset.mediaType == .image {
        _allAssets.append(asset)
      }
    })
  }
  
  static var selectedAssets = [PHAsset]()
    //插入一个选中的图片
  class func insertSelectedAssets(with asset: PHAsset) -> Bool {
    if IMUIGalleryDataManager.selectedAssets.count < IMUIGalleryDataManager.maxSeletedCount {
      IMUIGalleryDataManager.selectedAssets.append(asset)
      return true
    } else {
      return false
    }
  }
}
