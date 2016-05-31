//
//  JWHomeViewController.h
//  JWXer
//
//  Created by scjy on 16/2/17.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWNavigationController.h"

typedef void (^myTabBarControllerSelectedCount)(NSString *);

@interface JWHomeViewController : JWNavigationController

@property (nonatomic,copy)myTabBarControllerSelectedCount getSelectedCount;

@end
