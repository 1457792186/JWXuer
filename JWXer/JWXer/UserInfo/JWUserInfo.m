//
//  JWUserInfo.m
//  JWXuerIB
//
//  Created by scjy on 16/3/12.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWUserInfo.h"

@implementation JWUserInfo

+ (instancetype)shareUserInfo{
    
    return [[self alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static JWUserInfo * userInfo = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [super allocWithZone:zone];
        userInfo.userName = @"";
        userInfo.userID   = @"";
        userInfo.passWord = @"";
        userInfo.realName = @"";
        userInfo.sex      = @"";
        userInfo.email    = @"";
        userInfo.logo     = @"";
    });
    
    return userInfo;
}


- (void)saveInfo{
    NSString * savePath = [JWGetPath filePathWithFileName:@"userInfo" WithFileType:PLIST];
    NSData * saveData = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    if ([saveData writeToFile:savePath atomically:YES]) {
        NSLog(@"save success");
    } else{
        NSLog(@"save failed");
    }
        
    
}

- (JWUserInfo *)getInfo{
    NSString * filePath = [JWGetPath filePathWithFileName:@"userInfo" WithFileType:PLIST];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSLog(@"filePath is %@",filePath);
    
    id idValue = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return (JWUserInfo *)idValue;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.passWord forKey:@"passWord"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.logo forKey:@"logo"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.passWord = [aDecoder decodeObjectForKey:@"passWord"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"userName is %@", self.userName];
}

@end
