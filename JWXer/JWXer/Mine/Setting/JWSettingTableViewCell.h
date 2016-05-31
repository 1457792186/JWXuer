//
//  JWSettingTableViewCell.h
//  JWXer
//
//  Created by scjy on 16/2/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"

@interface JWSettingTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel * cellLabel;
@property (nonatomic,copy)NSString * labelName;

@property (nonatomic,strong)UIView * addCellView;

@end
