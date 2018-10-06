//
//  YHMissonCreatSuccessView.h
//  emake
//
//  Created by 谷伟 on 2018/1/7.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(id);
@interface YHMissonCreatSuccessView : UIView
@property (nonatomic, copy)Block block;
//创建团队
- (instancetype)initCreatTitle:(NSString *)title missionName:(NSString *)name content:(NSString *)contentText;
//邀请团队
- (instancetype)initInviteTitle:(NSString *)title missionName:(NSString *)name content:(NSString *)contentText;
//解散团队
- (instancetype)initDisbandView;
//剔除成员
- (instancetype)initEliminateMemeberView;
//队员加入团队成功
- (instancetype)initJoinSuccess:(NSString *)invitor missionName:(NSString *)name content:(NSString *)contentText;
- (void)showAnimated;
@end
