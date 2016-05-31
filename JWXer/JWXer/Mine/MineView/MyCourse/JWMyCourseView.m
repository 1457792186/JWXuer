//
//  JWMyCourseView.m
//  JWXer
//
//  Created by scjy on 16/2/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWMyCourseView.h"

@implementation JWMyCourseView

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
        self.myCourseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        [self addSubview:self.myCourseTableView];
    }
    return self;
}

@end
