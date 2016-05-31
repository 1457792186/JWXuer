//
//  JWStarView.m
//  JWXer
//
//  Created by scjy on 16/2/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWStarView.h"

@implementation JWStarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.starArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < 5; i++) {
            UIImageView * imageTemp = [[UIImageView alloc]initWithFrame:CGRectMake(10.f + i * (20.f + 20.f), 0.f, 20.f, 20.f)];
            imageTemp.image = [UIImage imageNamed:@"hongxin"];
            [self.starArray addObject:imageTemp];
            [self addSubview:imageTemp];
        }
        self.starCount = 5;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%ld",touches.count);
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"began %@",NSStringFromCGPoint(point));
    
    self.touchPoint = [touch locationInView:self];
    self.starCount = (self.touchPoint.x + 20.f) / 40;
    [self starShow];
}

- (void)starShow{
    for (int i = 0; i < 5; i++) {
        UIImageView * imageTemp = self.starArray[i];
        if (i < self.starCount) {
            imageTemp.image = [UIImage imageNamed:@"hongxin"];
        } else{
            imageTemp.image = [UIImage imageNamed:@"xin-hui"];
        }
    }
}

@end
