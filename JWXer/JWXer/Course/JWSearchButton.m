//
//  JWSearchButton.m
//  JWXer
//
//  Created by scjy on 16/2/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWSearchButton.h"

@implementation JWSearchButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        self.layer.cornerRadius = self.frame.size.height / 2;
        
        self.startSearchButton = [[UIButton alloc]init];
        [self.startSearchButton setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
        [self.startSearchButton setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateHighlighted];
        [self addSubview:self.startSearchButton];
        
        self.searchTextField = [[UITextField alloc]init];
        self.searchTextField.leftView = self.startSearchButton;
        self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
        self.searchTextField.keyboardType = UIKeyboardTypeDefault;
        self.searchTextField.textAlignment = NSTextAlignmentLeft;
        self.searchTextField.placeholder = @"搜索课程";
        [self.searchTextField setValue:[UIColor colorWithHexString:@"#f0f0f0"] forKeyPath:@"_placeholderLabel.textColor"];
        self.searchTextField.font = [UIFont systemFontOfSize:15.f];
        self.searchTextField.clearsOnBeginEditing = YES;
        [self addSubview:self.searchTextField];
    }
    return self;
}


- (void)layoutSubviews{
    self.startSearchButton.frame = CGRectMake(0.f, 0.f, self.frame.size.height, self.frame.size.height);
    self.startSearchButton.imageView.frame = self.startSearchButton.frame;
    
    self.searchTextField.frame = CGRectMake(0.f, 0.f, self.frame.size.width - self.startSearchButton.frame.size.width, self.frame.size.height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
