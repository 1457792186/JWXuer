//
//  ChangeBasicViewController.h
//  登陆界面
//
//  Created by scjy on 16/1/16.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWNavigationController.h"
#import "UITextField+RigisterViewCreate.h"
#import "UIColor+HexColor.h"
#import "ChangeProtorol.h"

@interface ChangeBasicViewController : JWNavigationController
@property (nonatomic,weak) id<ChangeInfo> delegate;
@property NSInteger viewControllerTag;

- (void)changeInfoSave;

@end
