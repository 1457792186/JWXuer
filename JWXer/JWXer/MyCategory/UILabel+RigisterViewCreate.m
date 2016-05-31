//
//  UILabel+RigisterViewCreate.m
//  登陆界面
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "UILabel+RigisterViewCreate.h"

@implementation UILabel (RigisterViewCreate)

+ (instancetype)initRigisterViewLabelX:(CGFloat)x withY:(CGFloat)y withW:(CGFloat)w withH:(CGFloat)h withText:(NSString *)text{
    UILabel * rigisterLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    rigisterLabel.text = text;
    rigisterLabel.textAlignment = NSTextAlignmentLeft;
    
    return rigisterLabel;
}

@end
