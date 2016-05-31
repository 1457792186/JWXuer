//
//  JWCommentTableViewCell.m
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWCommentTableViewCell.h"

@implementation JWCommentTableViewCell

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
        self.iconView = [[UIImageView alloc]init];
        [self addSubview:self.iconView];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:15.f];
        self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.nameLabel.numberOfLines = 1;
        [self addSubview:self.nameLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:10.f];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.timeLabel];
        
        self.commentTextView = [[UITextView alloc]init];
        self.commentTextView.textColor = [UIColor lightGrayColor];
        self.commentTextView.font = [UIFont systemFontOfSize:13.f];
        self.commentTextView.editable = NO;
        [self addSubview:self.commentTextView];
        
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (!dataDic) return;
    _dataDic = dataDic;
    if (self.iconView.image)return;
    
    NSInteger starCount = [[self.dataDic valueForKey:@"star"] integerValue];
    if (starCount >= 5) {
        starCount  = 5;
    }
    UIImage * imageStar = [UIImage imageNamed:@"xin-hui"];
    UIImage * imageRedStar = [UIImage imageNamed:@"hongxin"];
    for (int i = 0; i < 5; i++) {
        UIImageView * imageViewTemp = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 70.f - 10.f + i * (5.f + 10.f), 20.f, 10.f, 10.f)];
        if (i <= starCount - 1) {
            imageViewTemp.image = imageRedStar;
        } else{
            imageViewTemp.image = imageStar;
        }
        [self addSubview:imageViewTemp];
    }
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[dataDic valueForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"coursetupian2"]];
    self.nameLabel.text = [dataDic valueForKey:@"realname"];
    self.timeLabel.text = [dataDic valueForKey:@"tm"];
    self.commentTextView.text = [dataDic valueForKey:@"content"];
    
}

- (void)layoutSubviews{
    self.iconView.frame = CGRectMake(10.f, 10.f, 40.f, 40.f);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + 5.f, 10.f, 60.f, 15.f);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5.f, 10.f, 80.f, 15.f);
    self.commentTextView.frame = CGRectMake(self.nameLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame) + 5.f, self.frame.size.width - 70.f - 10.f - self.nameLabel.frame.origin.x, self.frame.size.height - CGRectGetMaxY(self.nameLabel.frame) - 5.f);
}

@end
