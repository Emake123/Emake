//
//  adressModel.h
//  emake
//
//  Created by eMake on 2017/9/9.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adressModel : NSObject

@property (nonatomic,copy)NSString *UserName;//UserName
@property (nonatomic,copy)NSString *MobileNumber;//MobileNumber
@property (nonatomic,copy)NSString *Province;//Province
@property (nonatomic,copy)NSString *City;//City
@property (nonatomic,copy)NSString *District;//District街道
@property (nonatomic,copy)NSString *Address;//Address
@property (nonatomic,copy)NSString *County;//County区

@property (nonatomic,strong)NSNumber *RefNo;//RefNo

@property (nonatomic,copy)NSString *UserId;//UserId

+(instancetype)initWithName:(NSString *)Name MobileNumber:(NSString *)MobileNumber Adress:(NSString *)Adress;

@end
