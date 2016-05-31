//
//  JWHomeCollectionViewCell.h
//  JWXer
//
//  Created by scjy on 16/2/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "UIImageView+WebCache.h"

@interface JWHomeCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView * courseImage;
@property (nonatomic,assign)NSString * imageName;

@property (nonatomic,strong)UILabel * courseLabel;
@property (nonatomic,assign)NSString * courseName;

@end
