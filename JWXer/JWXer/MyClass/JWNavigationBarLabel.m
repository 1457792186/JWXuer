//
//  JWNavigationBarLabel.m
//  JWXuer
//
//  Created by acher on 16/1/29.
//  Copyright (c) 2016年 acher. All rights reserved.
//

#import "JWNavigationBarLabel.h"

@implementation JWNavigationBarLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100.f)/2, 32.f, 100.f, 20.f);
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithHexString:@"#ffffff"];
        self.font = [UIFont boldSystemFontOfSize:20.f];
        
    }
    return self;
}

@end
