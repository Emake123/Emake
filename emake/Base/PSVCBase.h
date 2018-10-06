#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//通用block传值
typedef void(^Block)(id param);
typedef void(^shareBlock)();

//@protocol YHDelegate <NSObject>
//-(void)sharetest;
//@end
@interface PSVCBase : UIViewController

//通用block
@property (nonatomic, copy) Block block;

//@property (nonatomic, assign) id delegate;


-(void) addRootSubview:(UIView *) view;
-(void) layoutCustomNavigationBar;
-(void) back:(UIButton *)button;
-(void) addRightNavBtn:(NSString *)title;
- (void)addRightNavBtnWithImage:(NSString *)imageName;
- (void)rightBtnClick:(UIButton *)sender;
- (void)setRightBtnTitle:(NSString *)title;

-(UIToolbar *)addToolbar;
-(UIButton *)TopButton:(UIView *)bgView;
//导航返回首页以及消息展示
- (void)addRigthDetailButtonIsShowCart:(BOOL)isShow;
//分享
- (void)addRigthDetailButtonIsShowShare:(BOOL)isShow;
//liaotian
- (void)addRigthDetailButtonIsNotChat:(BOOL)isShow;
//多行列表
- (void)addRigthDetailButtonTeamIsShowCart:(BOOL)isShow;

- (void)addRightNavBtn:(NSString *)title showBordColor:(NSString *)myCololr;

- (void)addRightNavBtn:(NSString *)title showColor:(NSString *)myCololr;
//游客登录
- (bool)isVisitorLoginByPhoneNumberExits;

@end
