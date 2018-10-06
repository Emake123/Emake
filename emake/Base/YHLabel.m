//
//  YHLabel.m
//  emake
//
//  Created by 袁方 on 2017/7/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHLabel.h"

@implementation YHLabel

- (instancetype)init {
    return [self initWithText:nil textColor:nil];
}

- (instancetype)initWithText:(NSString *)text {
    return [self initWithText:text textColor:nil fontSize:NSNotFound];
}

- (instancetype)initWithTextColor:(NSString *)textColor {
    return [self initWithText:nil textColor:textColor fontSize:NSNotFound];
}

- (instancetype)initWithFontSize:(NSInteger)fontSize {
    return [self initWithText:nil textColor:nil fontSize:fontSize];
}

- (instancetype)initWithText:(NSString *)text textColor:(NSString *)textColor {
    return [self initWithText:text textColor:textColor fontSize:NSNotFound];
}

- (instancetype)initWithText:(NSString *)text fontSize:(NSInteger)fontSize {
    
    
    return [self initWithText:text textColor:nil fontSize:fontSize];
    
}
- (instancetype)initWithTextColor:(NSString *)textColor fontSize:(NSInteger)fontSize {
    return [self initWithText:nil textColor:textColor fontSize:fontSize];
}

- (instancetype)initWithText:(NSString *)text textColor:(NSString *)textColor fontSize:(NSInteger)fontSize {
    self = [super init];
    if (self) {
        if (text) {
            self.text = text;
        }
        if(textColor) {
            self.textColor = [UIColor colorWithHexString:textColor];
        }
        
        if (fontSize != NSNotFound) {
            self.font = SYSTEM_FONT(fontSize);
        } else {
            self.font = SYSTEM_FONT(BASE_FONT_SIZE);
        }
        
        [self sizeToFit];
    }
    return self;
}



@end
