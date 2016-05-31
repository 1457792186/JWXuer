//
//  JWUserInfo.h
//  JWXuerIB
//
//  Created by scjy on 16/3/12.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWBasicClass.h"
#import "JWGetPath.h"

@interface JWUserInfo : JWBasicClass<NSCoding>

@property (nonatomic,copy)NSString *userID;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *passWord;
@property (nonatomic,copy)NSString *realName;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *logo;

+ (instancetype)shareUserInfo;

- (void)saveInfo;

- (JWUserInfo *)getInfo;

@end
