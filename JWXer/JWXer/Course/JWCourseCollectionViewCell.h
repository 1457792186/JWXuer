//
//  JWCourseCollectionViewCell.h
//  JWXer
//
//  Created by scjy on 16/2/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "UIImageView+WebCache.h"

@interface JWCourseCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong)UIImageView * courseImageView;
@property (nonatomic,assign)NSString * courseImage;

@property (nonatomic,strong)UILabel * courseLabel;
@property (nonatomic,assign)NSString * courseName;

@end
