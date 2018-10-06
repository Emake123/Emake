//
//  HDPickerView.h
//  PickerViewDemo
//
//  Created by 郑超杰 on 2017/2/22.
//  Copyright © 2017年 ButterJie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectAreaBlock)(NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable area, NSArray * _Nullable streets);
typedef void(^SelectStreetBlock)( NSString * _Nullable
streets);

@interface HDPickerView : UIButton

@property (nonatomic, copy) SelectAreaBlock _Nullable selectAreaBlock;
@property (nonatomic, copy) SelectStreetBlock _Nullable selectStreetBlock;

@property (nonatomic, strong, nullable) NSMutableArray *StreetsArr;

@property (nonatomic, strong) void(^ _Nullable myBlock1)(NSArray *_Nullable);

/**
 初始化

 @param selectAreaBlock <#selectAreaBlock description#>
 @return <#return value description#>
 */
+ (instancetype _Nullable )selectArea:(SelectAreaBlock _Nullable )selectAreaBlock;
+ (instancetype _Nullable )selectStreet:(SelectStreetBlock _Nullable )selectAreaBlock arr:(NSArray *_Nullable)streets;
+ (instancetype)selectCity:(SelectAreaBlock)selectAreaBlock flag:(BOOL)selectCity ;
- (void)show;

- (void)dismiss;
@end
