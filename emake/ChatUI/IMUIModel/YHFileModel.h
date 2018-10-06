//
//  YHFileModel.h
//  emake
//
//  Created by 张士超 on 2018/5/26.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHFileModel : NSObject

@property (nonatomic,copy)NSString *FileName;
@property (nonatomic,copy)NSString *FileSize;
@property (nonatomic,copy)NSString *FilePath;
@property (nonatomic,copy)NSString *FileSendTime;


@end
@interface YHChatContractModel : NSObject

@property (nonatomic,copy)NSString *Text;
@property (nonatomic,copy)NSString *Image;
@property (nonatomic,copy)NSString *Url;
@property (nonatomic,copy)NSString *ContractType;
@property (nonatomic,copy)NSString *ContractNo;
@property (nonatomic,copy)NSString *IsIncludeTax;
@property (nonatomic,copy)NSString *ContractState;


@end

@interface YHChatVoiceModel : NSObject

@property (nonatomic,copy)NSString *VoiceLength;
@property (nonatomic,copy)NSString *VoiceFilePath;

@end
