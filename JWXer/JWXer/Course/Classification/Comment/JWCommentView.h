//
//  JWCommentView.h
//  JWXer
//
//  Created by scjy on 16/2/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "JSONKit.h"
#import "JWStarView.h"
#import "UIColor+HexColor.h"

@interface JWCommentView : UIView

@property (nonatomic,copy)NSString * userID;
@property (nonatomic,copy)NSString * courseID;

@property (nonatomic,strong)UITapGestureRecognizer * tap;

@property (nonatomic,strong)JWStarView * starView;
@property (nonatomic,strong)UITextView * commentView;
@property (nonatomic,strong)UIButton * sendButton;


@end
