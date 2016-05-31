//
//  JWCommentTableViewCell.h
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface JWCommentTableViewCell : UITableViewCell

@property (nonatomic,strong)NSDictionary * dataDic;

@property (nonatomic,strong)UIImageView * iconView;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UITextView * commentTextView;


@end
