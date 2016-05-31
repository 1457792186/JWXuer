//
//  JWMineView.m
//  JWXer
//
//  Created by scjy on 16/2/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWMineView.h"

@implementation JWMineView

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
        self.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        
        UITabBarController * tabBarTemp = [[UITabBarController alloc]init];
        CGFloat tabBarHeigh = tabBarTemp.tabBar.bounds.size.height;
        CGFloat viewHeigh = [UIScreen mainScreen].bounds.size.height - NavigationBarHeigh - tabBarHeigh;
        
        self.frame = CGRectMake(0.f, NavigationBarHeigh, [UIScreen mainScreen].bounds.size.width, viewHeigh);
        
    }
    return self;
}

@end
