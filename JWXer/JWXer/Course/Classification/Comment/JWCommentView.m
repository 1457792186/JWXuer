//
//  JWCommentView.m
//  JWXer
//
//  Created by scjy on 16/2/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWCommentView.h"

@implementation JWCommentView

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
        self.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
        
        UIView * viewShow = [[UIView alloc]initWithFrame:CGRectMake(5.f, 100.f, [UIScreen mainScreen].bounds.size.width - 5.f * 2, 175.f)];
        viewShow.backgroundColor = [UIColor whiteColor];
        viewShow.layer.cornerRadius = 10.f;
        
        UILabel * commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 5.f, viewShow.frame.size.width, 20.f)];
        commentLabel.textAlignment = NSTextAlignmentCenter;
        commentLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        commentLabel.text = @"评价";
        commentLabel.font = [UIFont boldSystemFontOfSize:20.f];
        [viewShow addSubview:commentLabel];
        
        self.starView = [[JWStarView alloc]initWithFrame:CGRectMake(viewShow.frame.size.width / 2 - 40.f * 2.5f, CGRectGetMaxY(commentLabel.frame) + 5.f, 40.f * 5, 20.f)];
        [viewShow addSubview:self.starView];
        
        self.commentView = [[UITextView alloc]initWithFrame:CGRectMake(5.f, CGRectGetMaxY(self.starView.frame) + 5.f, viewShow.frame.size.width - 5.f * 2, 65.f)];
        self.commentView.keyboardType = UIKeyboardTypeDefault;
        self.commentView.font = [UIFont systemFontOfSize:15.f];
        self.commentView.text = @"我也说一句...";
        self.commentView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        self.commentView.textColor = [UIColor lightGrayColor];
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentTapAction)];
        [self.commentView addGestureRecognizer:self.tap];
        [viewShow addSubview:self.commentView];
        
        self.sendButton = [[UIButton alloc]initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.commentView.frame) + 5.f, viewShow.frame.size.width, viewShow.frame.size.height - CGRectGetMaxY(self.commentView.frame) - 5.f)];
        self.sendButton.backgroundColor = [UIColor colorWithHexString:@"#46948a"];
        self.sendButton.layer.cornerRadius = 10.f;
        UILabel * sendLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.sendButton.frame.size.width - 40.f) / 2, (self.sendButton.frame.size.height - 20.f) / 2, 40.f, 20.f)];
        sendLabel.text = @"发送";
        sendLabel.textAlignment = NSTextAlignmentCenter;
        sendLabel.font = [UIFont systemFontOfSize:20.f];
        sendLabel.textColor = [UIColor whiteColor];
        [self.sendButton addSubview:sendLabel];
        [viewShow addSubview:self.sendButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        
        UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, viewShow.frame.origin.y)];
        topView.backgroundColor = [UIColor clearColor];
        [self addSubview:topView];
        [topView addGestureRecognizer:tap];
        UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0.f, CGRectGetMaxY(viewShow.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(viewShow.frame))];
        bottomView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomView];
        [bottomView addGestureRecognizer:tap];
        [self addSubview:viewShow];
    }
    return self;
}

-(void)tapAction{
    [self removeFromSuperview];
}

- (void)commentTapAction{
    self.commentView.text = @"";
    self.commentView.textColor = [UIColor blackColor];
    [self.commentView removeGestureRecognizer:self.tap];
    [self.commentView becomeFirstResponder];
}



@end
