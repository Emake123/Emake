//
//  IMUICameraPreviewView.swift
//  IMUIChat
//
//  Created by oshumini on 2017/3/12.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import AVFoundation

class IMUICameraPreviewView: UIView {

    //预览图层
  var videoPreviewLayer: AVCaptureVideoPreviewLayer {
    return layer as! AVCaptureVideoPreviewLayer
  }
  //媒体（音、视频）捕获会话
  var session: AVCaptureSession? {
    get {
      return videoPreviewLayer.session
    }
    set {
      videoPreviewLayer.session = newValue
    }
  }
  
  override class var layerClass: AnyClass {
    return AVCaptureVideoPreviewLayer.self
  }
  
  override var frame: CGRect {
    didSet {
      
      let videoLayer = self.layer as! AVCaptureVideoPreviewLayer
      videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
  }

}
