//
//  JWMyCourseTableViewCell.h
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface JWMyCourseTableViewCell : UITableViewCell


@property (nonatomic,strong)NSDictionary * courseDic;
@property (nonatomic,strong)UIImageView * courseImageView;

@property (nonatomic,strong)UILabel * courseNameLabel;
@property (nonatomic,strong)UILabel * prograssLabel;

@property (nonatomic,strong)UIView * progressShowView;
@property (nonatomic,assign)CGFloat progressShowViewWidth;

@end
