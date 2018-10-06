#import "UIView+PSAutoLayout.h"

@implementation UIView (PSAutoLayout)

-(void) PSSetConstraint: (CGFloat) left Right:(CGFloat) right Top:(CGFloat) top Bottom:(CGFloat) bottom
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:top];

    cn.active = YES;
    cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:left];

    cn.active = YES;
    cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-right];
    cn.active = YES;

    cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-bottom];
    cn.active = YES;
}

-(void) PSSetWidth: (CGFloat) width
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    cn.active = YES;
}

-(void) PSSetHeight: (CGFloat) height
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    cn.active = YES;
}

-(void) PSSetSize: (CGFloat) width Height:(CGFloat) height
{
    [self PSSetWidth:width];
    [self PSSetHeight:height];
}

-(void) PSSetLeft: (CGFloat) length
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:length];
    cn.active = YES;
}

-(void) PSSetRight:(CGFloat) length
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:-length];
    cn.active = YES;
}

-(void) PSSetTop:(CGFloat) length
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:length];
    cn.active = YES;
}

-(void) PSSetBottom: (CGFloat) length
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-length];
    cn.active = YES;
}

-(void) PSSetBottomAtItem:(id) item Length:(CGFloat) length
{
    /*
      NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
         [self addConstraint:cn];
         */
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeBottom multiplier:1.0 constant:length];
    cn.active = YES;

}

-(void) PSSetRightAtItem: (id) item Length:(CGFloat) length
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    cn.active = YES;
    
    cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:length];
    cn.active = YES;
}
-(void) PSSetLeftAtItem: (id) item Length:(CGFloat) length
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    cn.active = YES;
    
    cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeading multiplier:1.0 constant:length];
    cn.active = YES;
}
-(void) PSSetRightAtItemCenter: (id) item1 Lenght:(CGFloat) lenght
{
    /*
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeRight multiplier:1.0 constant:lenght];
    cn.active = YES;
     */
}

-(void) PSSetCenterHorizontalAtItem: (id) item
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    cn.active = YES;
}

-(void) PSSetCenterVerticalAtItem: (id) item
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    cn.active = YES;
}

-(void) PSSetCenterXPercent: (CGFloat) offset
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:offset*ScreenWidth];
    cn.active = YES;
}

-(void) PSSetCenterX
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    cn.active = YES;
}









-(void) PSSetCenterXWithItem: (id) item
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    cn.active = YES;
}

-(void) PSSetCenterXWithItem: (id) item Offset:(CGFloat) offset
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:offset constant:0.0];
    cn.active = YES;
}

-(void) PSSetCenterXOnItem: (id) item1 OnItem: (id) item2
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    cn.active = YES;
}



-(void) PSSetCenterYWithItem: (id) item Offset:(CGFloat) offset
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:offset constant:0.0];
    cn.active = YES;
}

-(void) PSSetCenterYOnItem: (id) item1 OnItem: (id) item2
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    cn.active = YES;
}



#pragma TOP

-(void) PSSetTopWithItemCenter: (id) item Lenght:(CGFloat) lenght
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:lenght];
    cn.active = YES;
}






-(void) PSSetLeftOnItem: (id) item1 OnItem:(id) item2 Lenght:(CGFloat) lenght
{
   
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    cn.active = YES;
    
    cn = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-lenght];
    cn.active = YES;
}

-(void) PSSetLeftByItem: (id) item1 ByItem:(id) item2 Lenght:(CGFloat) lenght
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:item1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item2 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:lenght];
    cn.active = YES;
}

-(void)PSUpdateConstraintsHeight:(CGFloat)height
{
    NSArray *constrains = self.constraints;
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = height;
        }
        if (constraint.firstAttribute == NSLayoutAttributeBottomMargin) {

            constraint.constant = height;

        }
    }

}
-(void)PSUpdateConstraintsWidth:(CGFloat)Width
{
    NSArray *constrains = self.constraints;
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            constraint.constant = Width;
        }
    }
    
}



//NSLayoutConstraint:0x600000289100 UIView:0x7fe2a26b68e0.width == 375>,
//<NSLayoutConstraint:0x60000028e560 UILabel:0x7fe2a267da00.top == UIView:0x7fe2a26b68e0.top>,
//<NSLayoutConstraint:0x60000028e010 UILabel:0x7fe2a267da00.centerX == UIView:0x7fe2a26b68e0.centerX>,
//<NSLayoutConstraint:0x60000028eab0 UILabel:0x7fe2a267dce0.top == UILabel:0x7fe2a267da00.bottom + 8>,
//<NSLayoutConstraint:0x60000028ea60 UILabel:0x7fe2a267dce0.left == UIView:0x7fe2a26b68e0.left + 17>,
//<NSLayoutConstraint:0x60000028c800 UILabel:0x7fe2a267dfc0.right == UIView:0x7fe2a26b68e0.right - 11>,
//<NSLayoutConstraint:0x60000028ef60 UILabel:0x7fe2a26b4530.top == UILabel:0x7fe2a267da00.bottom + 8>,
//<NSLayoutConstraint:0x60000028eec0 UILabel:0x7fe2a26b4530.right == UIView:0x7fe2a26b68e0.right - 11>,
//<NSLayoutConstraint:0x60000028e880 UILabel:0x7fe2a269f140.top == UILabel:0x7fe2a26b4530.bottom + 5>,
//<NSLayoutConstraint:0x60000028e920 UILabel:0x7fe2a269f140.left == UIView:0x7fe2a26b68e0.left + 24>,
//<NSLayoutConstraint:0x60000028d160 UILabel:0x7fe2a269f700.top == UILabel:0x7fe2a269f140.bottom + 3>,
//<NSLayoutConstraint:0x60000028ee20 UILabel:0x7fe2a269f700.left == UIView:0x7fe2a26b68e0.left + 274>,
//<NSLayoutConstraint:0x60000028d7f0 UILabel:0x7fe2a269f700.bottom == UIView:0x7fe2a26b68e0.bottom - 10>
//)

@end
