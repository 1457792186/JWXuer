//
//  JWBeforeLoginView.m
//  JWXer
//
//  Created by scjy on 16/2/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWBeforeLoginView.h"

@implementation JWBeforeLoginView

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
        self.logoView = [[UIImageView alloc]init];
        self.logoView.image = [UIImage imageNamed:@"dengluqian"];
        [self addSubview:self.logoView];
        
        self.loginLeabel = [[UILabel alloc]init];
        self.loginLeabel.text = @"立即登录";
        self.loginLeabel.textAlignment = NSTextAlignmentCenter;
        self.loginLeabel.textColor = [UIColor whiteColor];
        self.loginLeabel.font = [UIFont boldSystemFontOfSize:20.f];
        
        self.loginButton = [[UIButton alloc]init];
        [self.loginButton setImage:[UIImage imageNamed:@"anniu2"] forState:UIControlStateNormal];
        [self addSubview:self.loginButton];
        [self.loginButton addSubview:self.loginLeabel];
        
    }
    return self;
}




- (void)layoutSubviews{
    self.logoView.frame = CGRectMake((self.frame.size.width - 106.f)/2, 175.f, 106.f, 62.f);
    
    self.loginButton.frame = CGRectMake((self.frame.size.width - 250.f)/2, CGRectGetMaxY(self.logoView.frame) + 60.f, 250.f, 42.f);
    self.loginButton.layer.cornerRadius = 20.f;
    
    self.loginLeabel.frame = CGRectMake(0.f, 0.f, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
    
}

@end
