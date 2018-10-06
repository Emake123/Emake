#import "PSButtonBase.h"

@implementation PSButtonBase

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (UIImage*) createImageWithColor: (UIColor*) color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void) setBorderColor: (UIColor*) color
{
    self.layer.borderColor = [color CGColor];
}

@end



@implementation PSButtonBorder

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 1.0;
    }
    return self;
}

@end

//
@implementation PSButtonTextDonw

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat spacing = 0.0;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height - (imageSize.height + spacing))];
    self.imageView.frame = CGRectMake((self.frame.size.width - imageSize.width)/2, (self.frame.size.height - (imageSize.height+spacing+titleSize.height))/2, imageSize.width, imageSize.height);
    self.titleLabel.frame = CGRectMake((self.frame.size.width - titleSize.width)/2, CGRectGetMaxY(self.imageView.frame)+spacing, titleSize.width, titleSize.height);
}

@end



//圆形按钮
@implementation PSButtonArc

-(instancetype) init
{
    self = [super init];
    if (self)
    {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.borderWidth = 0;
    }
    return self;
}

/*
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat spacing = 6.0;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height - (imageSize.height + spacing))];
    self.imageView.frame = CGRectMake((self.frame.size.width - imageSize.width)/2, (self.frame.size.height - (imageSize.height+spacing+titleSize.height))/2, imageSize.width, imageSize.height);
    self.titleLabel.frame = CGRectMake((self.frame.size.width - titleSize.width)/2, CGRectGetMaxY(self.imageView.frame)+spacing, titleSize.width, titleSize.height);
}
 */

@end
