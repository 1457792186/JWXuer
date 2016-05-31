//
//  UITextField+RigisterViewCreate.m
//  登陆界面
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "UITextField+RigisterViewCreate.h"

@implementation UITextField (RigisterViewCreate)


+ (instancetype)initRigisterViewTextFieldX:(CGFloat)x withY:(CGFloat)y withW:(CGFloat)w withH:(CGFloat)h withText:(NSString *)text{
    UITextField *rigisterTextField = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    rigisterTextField.placeholder = text;
    rigisterTextField.keyboardType = UIKeyboardTypeDefault;
    rigisterTextField.clearsOnBeginEditing = YES;
    
    return rigisterTextField;
}


+ (instancetype)initRigisterViewTextFieldX:(CGFloat)x withY:(CGFloat)y withW:(CGFloat)w withH:(CGFloat)h{
    UITextField *rigisterTextField = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    rigisterTextField.keyboardType = UIKeyboardTypeDefault;
    rigisterTextField.clearsOnBeginEditing = YES;
    
    return rigisterTextField;
}

@end
