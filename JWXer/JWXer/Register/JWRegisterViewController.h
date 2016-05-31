//
//  JWRegisterViewController.h
//  JWXer
//
//  Created by scjy on 16/2/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWNavigationController.h"

//Block
typedef void (^userNameAndPassWord)(NSString *,NSString *);

@interface JWRegisterViewController : JWNavigationController

@property (nonatomic,copy)userNameAndPassWord getPass;

@end
