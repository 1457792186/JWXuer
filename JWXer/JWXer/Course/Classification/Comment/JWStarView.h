//
//  JWStarView.h
//  JWXer
//
//  Created by scjy on 16/2/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWStarView : UIView

@property (nonatomic,assign)NSInteger starCount;

@property (nonatomic,strong)NSMutableArray * starArray;

@property CGPoint touchPoint;

@end
