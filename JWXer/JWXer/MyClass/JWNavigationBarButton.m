//
//  JWNavigationBarButton.m
//  JWXuer
//
//  Created by acher on 16/1/29.
//  Copyright (c) 2016年 acher. All rights reserved.
//

#import "JWNavigationBarButton.h"

@implementation JWNavigationBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (void)setImageName:(NSString *)imageName{
    if (!imageName) return;
    self.frame = CGRectMake(15.f, 30.f, 20.f, 25.f);
    self.backgroundColor = [UIColor colorWithHexString:@"#54a7a0"];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    imageView.image = [UIImage imageNamed:imageName];
    [self addSubview:imageView];
    
}


- (void)setTittleName:(NSString *)tittleName{
    if (!tittleName)return;
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15.f - 36.f, 36.f, 36.f, 20.f);
    self.backgroundColor = [UIColor clearColor];
    UILabel * btnLabel = [[UILabel alloc]initWithFrame:self.frame];
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    btnLabel.font = [UIFont boldSystemFontOfSize:20.f];
    btnLabel.text = tittleName;
    [self addSubview:btnLabel];
    
}



@end
