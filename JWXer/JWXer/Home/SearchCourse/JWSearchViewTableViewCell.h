//
//  JWSearchViewTableViewCell.h
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface JWSearchViewTableViewCell : UITableViewCell

@property (nonatomic,strong)NSDictionary * searchDic;
@property (nonatomic,strong)UIImageView * searchImageView;

@property (nonatomic,strong)UILabel * courseNameLabel;
@property (nonatomic,strong)UILabel * studentCountLabel;
@property (nonatomic,strong)UILabel * updatetimeLabel;


@end
