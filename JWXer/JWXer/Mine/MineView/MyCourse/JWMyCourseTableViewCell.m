//
//  JWMyCourseTableViewCell.m
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWMyCourseTableViewCell.h"

@implementation JWMyCourseTableViewCell

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
        self.courseImageView = [[UIImageView alloc]init];
        [self addSubview:self.courseImageView];
        
        self.courseNameLabel = [[UILabel alloc]init];
        self.courseNameLabel.font = [UIFont systemFontOfSize:20.f];
        [self addSubview:self.courseNameLabel];
        
        self.prograssLabel = [[UILabel alloc]init];
        self.prograssLabel.font = [UIFont systemFontOfSize:15.f];
        self.prograssLabel.textColor = [UIColor grayColor];
        [self addSubview:self.prograssLabel];
        
        self.progressShowView = [[UIView alloc]init];
        self.progressShowView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.progressShowView];
        self.progressShowView.layer.cornerRadius = 3.f;
        
        self.progressShowViewWidth = 0.f;
    }
    return self;
}

- (void)setCourseDic:(NSDictionary *)courseDic{
    if (!courseDic)return;
    _courseDic = courseDic;
    if (self.courseImageView.image)return;
    [self.courseImageView sd_setImageWithURL:[NSURL URLWithString:[_courseDic valueForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"logo"]];
    
    self.courseNameLabel.text = [_courseDic valueForKey:@"stitle"];
    self.prograssLabel.text = [NSString stringWithFormat:@"已学过%@",[_courseDic valueForKey:@"jindu"]];
    self.progressShowViewWidth = [[_courseDic valueForKey:@"jindu"] floatValue] / 100.f;
}

- (void)layoutSubviews{
    self.courseImageView.frame = CGRectMake(8.f, 10.f, 120.f, 80.f);
    self.courseNameLabel.frame = CGRectMake(CGRectGetMaxX(self.courseImageView.frame) + 8.f, self.courseImageView.frame.origin.y, self.frame.size.width - (CGRectGetMaxX(self.courseImageView.frame) + 8.f), 15.f);
    self.prograssLabel.frame = CGRectMake(self.courseNameLabel.frame.origin.x, 45.f, self.courseNameLabel.frame.size.width, 20.f);
    CGFloat progressWidth = self.progressShowViewWidth * self.courseNameLabel.frame.size.width;
    self.progressShowView.frame = CGRectMake(self.courseNameLabel.frame.origin.x, CGRectGetMaxY(self.prograssLabel.frame) + 5.f, progressWidth, 5.f);
}

@end
