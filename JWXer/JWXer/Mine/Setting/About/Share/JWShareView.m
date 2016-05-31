//
//  JWShareView.m
//  JWXer
//
//  Created by scjy on 16/2/25.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWShareView.h"

@implementation JWShareView
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
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.2f];
        
        NSArray * imageNameArray = @[@"weiboButton",@"weChatButton",@"friendcircle",@"QQButton"];
        NSArray * tittleNameArray = @[@"新浪微博",@"微信",@"朋友圈",@"QQ"];
        
        UIView * viewShow = [[UIView alloc]initWithFrame:CGRectMake(0.f, [UIScreen mainScreen].bounds.size.height - 200.f, [UIScreen mainScreen].bounds.size.width, 200.f)];
        viewShow.backgroundColor = [UIColor whiteColor];
        
        CGFloat buttonEndge = ([UIScreen mainScreen].bounds.size.width - 50 * 3 ) / 6;
        CGFloat buttonTopEndge = 20.f;
        for (int i = 0; i < imageNameArray.count; i ++) {
            UIButton * shareButton = [[UIButton alloc]init];
            if (i < 3) {
                shareButton.frame = CGRectMake(buttonEndge  + (50.f + buttonEndge + buttonEndge) * i, buttonTopEndge, 50.f, 70.f);
            } else{
                shareButton.frame = CGRectMake(buttonEndge, buttonTopEndge + 70.f + buttonTopEndge, 50.f, 70.f);
            }
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, shareButton.frame.size.width, shareButton.frame.size.width)];
            imageView.image = [UIImage imageNamed:imageNameArray[i]];
            [shareButton addSubview:imageView];
            
            UILabel * shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, shareButton.frame.size.width, shareButton.frame.size.width, shareButton.frame.size.height - shareButton.frame.size.width)];
            shareLabel.textAlignment = NSTextAlignmentCenter;
            shareLabel.font = [UIFont systemFontOfSize:12.f];
            shareLabel.text = tittleNameArray[i];
            [shareButton addSubview:shareLabel];
            
            shareButton.tag = 10000 + i;
            [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            [viewShow addSubview:shareButton];
        }
        
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:self.tap];
        [self addSubview:viewShow];
    }
    return self;
}

- (void)tapAction{
    [self removeGestureRecognizer:self.tap];
    
    [self removeFromSuperview];
}


- (void)shareAction:(UIButton *)shareButton{
    if (shareButton.tag == 10000) {
        NSLog(@"分享到新浪");
    } else if (shareButton.tag == 10001){
        
    } else if (shareButton.tag == 10002){
        
    } else{
        
    }
}

@end
