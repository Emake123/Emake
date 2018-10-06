//
//  FindPasswordView.h
//  emake
//
//  Created by eMake on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPasswordView : UIView

@property(nonatomic,strong) UIButton *BtnSure;
@property(nonatomic,strong) UITextField  *textMobilPhone;
@property(nonatomic,strong) UITextField  *textCode;
@property(nonatomic,strong) UITextField  *textPassword;
@property(nonatomic,strong) UITextField  *textChooseCatagory;
@property(nonatomic,strong) UIButton  *BtnChooseCatagory;

@property(nonatomic,strong) UIButton *getCodeBtn;
@property(nonatomic,strong) UIButton *showPasswordBtn;
@property(nonatomic ,strong)UIButton *invatedBtn;
@property(nonatomic ,strong)UITextField *inviteText;
@property(nonatomic,strong)UIButton *userPermission;
@property(nonatomic,strong)UIButton *userServers;
@property(nonatomic,strong)UIButton *userPrivate;

-(void)loginVIewWith:(UIView *)BackgroudView isInvented:(BOOL)isInvented;

@end
