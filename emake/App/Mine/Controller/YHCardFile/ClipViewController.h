//
//  ClipViewController.h
//  ClipImage
//
//  Created by zhao on 16/11/1.
//  Copyright © 2016年 zhaoName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSVCBase.h"
@protocol ClipViewControllerDelegate <NSObject>

- (void)didSuccessClipImage:(UIImage *)clipedImage;

@end

@interface ClipViewController : PSVCBase
//当为yes自动返回上一页
@property (nonatomic, assign) BOOL backVC;

@property (nonatomic, strong) UIImage *needClipImage;
@property (nonatomic, weak) id<ClipViewControllerDelegate> delegate;

@end
