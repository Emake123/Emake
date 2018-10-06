//
//  chatUserModel.h
//  emake
//
//  Created by 谷伟 on 2017/9/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chatUserModel : NSObject

@property (nonatomic,copy)NSString *Avatar;
@property (nonatomic,copy)NSString *UserId;
@property (nonatomic,copy)NSString *Group;
@property (nonatomic,copy)NSString *DisplayName;
@property (nonatomic,copy)NSString *PhoneNumber;
@property (nonatomic,copy)NSString *UserType;
@property (nonatomic,copy)NSString *ClientID;
@property (nonatomic,copy)NSString *sendTime;

- (instancetype)initWith:(NSString *)avatar formId:(NSString *)formId displayName:(NSString *)displayName phoneNumber:(NSString *)phone userType:(NSString *)userType clientID:(NSString *)clientID;

@end
