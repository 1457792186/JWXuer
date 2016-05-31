//
//  JWNavigationBar.m
//  JWXer
//
//  Created by scjy on 16/2/17.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWNavigationBar.h"
#import "UIColor+HexColor.h"

const CGFloat NavigationBarHeigh = 64.f;

@implementation JWNavigationBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, NavigationBarHeigh);
        self.backgroundColor = [UIColor colorWithHexString:@"#54a7a0"];
    }
    return self;
}

@end
