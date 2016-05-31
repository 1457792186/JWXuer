//
//  UITextField+RigisterViewCreate.h
//  登陆界面
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (RigisterViewCreate)


+ (instancetype)initRigisterViewTextFieldX:(CGFloat)x withY:(CGFloat)y withW:(CGFloat)w withH:(CGFloat)h withText:(NSString *)text;

+ (instancetype)initRigisterViewTextFieldX:(CGFloat)x withY:(CGFloat)y withW:(CGFloat)w withH:(CGFloat)h;

@end
