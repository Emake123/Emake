#import <UIKit/UIKit.h>

@interface PSButtonBase : UIButton

- (UIImage*) createImageWithColor: (UIColor*) color __attribute__((unavailable("该方法废弃")));
- (void) setBorderColor: (UIColor*) color;
@end

//纯色按钮
@interface PSButtonBorder : PSButtonBase

@end

//文字在下
@interface PSButtonTextDonw : PSButtonBase

@end

//圆形按钮
@interface PSButtonArc : PSButtonBase

@end
