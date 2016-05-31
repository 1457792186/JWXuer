//
//  UserInfoTableViewCell.h
//  登陆界面
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWUserInfo.h"
#import "UIColor+HexColor.h"
#import "UIImageView+WebCache.h"

@interface UserInfoTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>
@property CGFloat rowH;

@property (nonatomic,copy)NSString * tittle;
@property (nonatomic,strong)UILabel * tittleLabel;

@property (nonatomic,copy)NSString * info;
@property (nonatomic,strong)UILabel * infoLabel;

@property (nonatomic,copy)NSString * logoName;
@property (nonatomic,strong)UIImageView * logoImageView;


@end
