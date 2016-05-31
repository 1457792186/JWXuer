//
//  JWIndexTableViewCell.h
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWIndexTableViewCell : UITableViewCell

@property (nonatomic,strong)NSDictionary * dataDic;

@property (nonatomic,strong)UILabel * courseNameLabel;
@property (nonatomic,strong)UIButton * downLoadButton;

@property (nonatomic,assign)NSInteger selectCount;
@property (nonatomic,assign)BOOL downLoadIng;

@end
