#import <UIKit/UIKit.h>
@interface UIView (PSAutoLayout)

//设置自身在父视图的边距
-(void) PSSetConstraint: (CGFloat) left Right:(CGFloat) right Top:(CGFloat) top Bottom:(CGFloat) bottom;

//设置自身的宽度
-(void) PSSetWidth: (CGFloat) width;

//设置自身的高度
-(void) PSSetHeight: (CGFloat) height;

//设置自身的尺寸
-(void) PSSetSize: (CGFloat) width Height:(CGFloat) height;

//设置自身的左边距离父视图左边的距离
-(void) PSSetLeft: (CGFloat) length;

//设置自身的顶部距离父视图顶部的距离
-(void) PSSetTop: (CGFloat) length;

//设置自身的右边距离父视图右边的距离
-(void) PSSetRight:(CGFloat) length;

//设置自身在另一个视图的下方的距离
-(void) PSSetBottomAtItem:(id) item Length:(CGFloat) length;

//设置自身的底部距离父视图底部的距离
-(void) PSSetBottom: (CGFloat) length;

//设置自身在另一个视图的右侧距离
-(void) PSSetRightAtItem: (id) item Length:(CGFloat) length;

//设置自身在另一个视图的右侧距离
-(void) PSSetLeftAtItem: (id) item Length:(CGFloat) length;

//设置自身在另一个视图的右侧（垂直中心对齐）距离
-(void) PSSetRightAtItemCenter: (id) item1 Length:(CGFloat) length;

//设置自身在另一个视图的左侧距离

//垂直方向(X轴)对齐
-(void) PSSetCenterVerticalAtItem: (id) item;

//水平中心(Y轴)对齐
-(void) PSSetCenterHorizontalAtItem: (id) item;

//设置水平方向（X轴）的百分比分布
-(void) PSSetCenterXPercent: (CGFloat) offset;

//设置水平方向（X轴）居中
-(void) PSSetCenterX;


//todo fixed to superview
//水平居中
-(void) PSSetCenterXWithItem: (id) item;
-(void) PSSetCenterXWithItem: (id) item Offset:(CGFloat) offset;
-(void) PSSetCenterXOnItem: (id) item1 OnItem: (id) item2;

//垂直居中

-(void) PSSetCenterYWithItem: (id) item Offset:(CGFloat) offset;
-(void) PSSetCenterYOnItem: (id) item1 OnItem: (id) item2;


//Item中心距离顶部
-(void) PSSetTopWithItemCenter: (id) item Lenght:(CGFloat) lenght;


-(void) PSSetLeftOnItem: (id) item1 OnItem:(id) item2 Lenght:(CGFloat) lenght;
-(void) PSSetLeftByItem: (id) item1 ByItem:(id) item2 Lenght:(CGFloat) lenght;

//刷新高度
-(void)PSUpdateConstraintsHeight:(CGFloat)height;

//刷新宽度
-(void)PSUpdateConstraintsWidth:(CGFloat)Width;




@end
