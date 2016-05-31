//
//  JWSettingTableViewCell.m
//  JWXer
//
//  Created by scjy on 16/2/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWSettingTableViewCell.h"

@implementation JWSettingTableViewCell

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
        
        self.cellLabel = [[UILabel alloc]init];
        self.cellLabel.frame = CGRectMake(20.f, (self.frame.size.height - 30.f ) / 2, ([UIScreen mainScreen].bounds.size.width - 20.f * 2) - 80.f, 30.f);
        self.cellLabel.textAlignment = NSTextAlignmentLeft;
        self.cellLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        self.cellLabel.font = [UIFont systemFontOfSize:15.f];
        self.cellLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:self.cellLabel];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(20.f, self.frame.size.height - 1.f, [UIScreen mainScreen].bounds.size.width - 80.f, 0.5f)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        self.addCellView = [[UIView alloc]init];
        self.addCellView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 20.f - 80.f, (self.frame.size.height - 30.f ) / 2, 80.f, 30.f);
        [self addSubview:self.addCellView];
    }
    
    return self;
}

#pragma mark - SettingProperty
- (void)setLabelName:(NSString *)labelName{
    if (!labelName)return;
    
    _labelName = labelName;
    if (!self.cellLabel)return;
    
    self.cellLabel.text = labelName;

}



@end
