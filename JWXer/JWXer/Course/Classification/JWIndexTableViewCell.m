//
//  JWIndexTableViewCell.m
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWIndexTableViewCell.h"

@implementation JWIndexTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (self.selectCount > 0) {
        self.downLoadIng = !self.downLoadIng;
    }
    
    if (self.downLoadIng == 0) {
        [self.downLoadButton setImage:[UIImage imageNamed:@"courseXiazai"] forState:UIControlStateNormal];
    } else{
        [self.downLoadButton setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    }
    
    self.selectCount++;
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.courseNameLabel = [[UILabel alloc]init];
        self.courseNameLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:self.courseNameLabel];
        
        self.downLoadButton = [[UIButton alloc]init];
        [self.downLoadButton setImage:[UIImage imageNamed:@"courseXiazai"] forState:UIControlStateNormal];
        [self addSubview:self.downLoadButton];
        
        self.selectCount = 0;
        self.downLoadIng = 0;
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic) return;
    _dataDic = dataDic;
    
    self.courseNameLabel.text = [dataDic valueForKey:@"title"];
}

- (void)layoutSubviews{
    self.courseNameLabel.frame = CGRectMake(40.f, self.frame.size.height - 10.f - 20.f, self.frame.size.width - 40.f * 2, 20.f);
    self.downLoadButton.frame = CGRectMake(self.frame.size.width - 40.f, 10.f, 20.f, 20.f);
}

@end
