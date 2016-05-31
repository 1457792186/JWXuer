//
//  JWHomePageControl.m
//  JWXer
//
//  Created by scjy on 16/2/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWHomePageControl.h"

@implementation JWHomePageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame withPageCount:(NSInteger)pageCount{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.numberOfPages = pageCount;
        self.pageIndicatorTintColor = [UIColor whiteColor];
        self.currentPageIndicatorTintColor = [UIColor cyanColor];
        
    }
    return self;
}

@end
