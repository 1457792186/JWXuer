//
//  JWSearchViewTableViewCell.m
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWSearchViewTableViewCell.h"

@implementation JWSearchViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.searchImageView = [[UIImageView alloc]init];
        [self addSubview:self.searchImageView];
        
        self.courseNameLabel = [[UILabel alloc]init];
        self.courseNameLabel.font = [UIFont systemFontOfSize:20.f];
        [self addSubview:self.courseNameLabel];
        
        self.studentCountLabel = [[UILabel alloc]init];
        self.studentCountLabel.font = [UIFont systemFontOfSize:10.f];
        self.studentCountLabel.textColor = [UIColor grayColor];
        [self addSubview:self.studentCountLabel];
        
        self.updatetimeLabel = [[UILabel alloc]init];
        self.updatetimeLabel.font = [UIFont systemFontOfSize:10.f];
        self.updatetimeLabel.textColor = [UIColor grayColor];
        [self addSubview:self.updatetimeLabel];
    }
    return self;
}

- (void)setSearchDic:(NSDictionary *)searchDic{
    if (!searchDic)return;
    _searchDic = searchDic;
    if (self.searchImageView.image)return;
    
    NSInteger starCount = [[_searchDic valueForKey:@"star"] integerValue] / 2;
    UIImage * imageStar = [UIImage imageNamed:@"xin-hui"];
    UIImage * imageRedStar = [UIImage imageNamed:@"hongxin"];
    for (int i = 0; i < 5; i++) {
        UIImageView * imageViewTemp = [[UIImageView alloc]initWithFrame:CGRectMake(140.f + i * (10.f + 5.f), 30.f, 10.f, 10.f)];
        if (i <= starCount - 1) {
            imageViewTemp.image = imageRedStar;
        } else{
            imageViewTemp.image = imageStar;
        }
        [self addSubview:imageViewTemp];
    }
    [self.searchImageView sd_setImageWithURL:[NSURL URLWithString:[_searchDic valueForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"logo"]];
    
    self.courseNameLabel.text = [_searchDic valueForKey:@"stitle"];
    self.studentCountLabel.text = [NSString stringWithFormat:@"%@人正在学习",[_searchDic valueForKey:@"count"]];
    self.updatetimeLabel.text = [NSString stringWithFormat:@"更新时间%@",[_searchDic valueForKey:@"updatetime"]];
}

- (void)layoutSubviews{
    self.searchImageView.frame = CGRectMake(8.f, 10.f, 120.f, 80.f);
    self.courseNameLabel.frame = CGRectMake(CGRectGetMaxX(self.searchImageView.frame) + 8.f, self.searchImageView.frame.origin.y, self.frame.size.width - (CGRectGetMaxX(self.searchImageView.frame) + 8.f), 15.f);
    self.studentCountLabel.frame = CGRectMake(self.courseNameLabel.frame.origin.x, 45.f, self.courseNameLabel.frame.size.width, 10.f);
    self.updatetimeLabel.frame = CGRectMake(self.courseNameLabel.frame.origin.x, CGRectGetMaxY(self.studentCountLabel.frame) + 5.f, self.courseNameLabel.frame.size.width, 10.f);
}

@end
