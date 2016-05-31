//
//  UserInfoTableViewCell.m
//  登陆界面
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

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
        self.rowH = self.frame.size.height;
        
        self.tittleLabel = [[UILabel alloc]init];
        self.tittleLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        self.tittleLabel.backgroundColor = [UIColor whiteColor];
        
        self.tittleLabel.font = [UIFont boldSystemFontOfSize:20.f];
        
        self.infoLabel = [[UILabel alloc]init];
        self.infoLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        self.infoLabel.font = [UIFont boldSystemFontOfSize:20.f];
        self.infoLabel.textAlignment = NSTextAlignmentRight;
        
        self.logoImageView= [[UIImageView alloc]init];
    }
    
    return self;
}


#pragma mark- ReSet Properties


- (void)setTittle:(NSString *)tittle{
    if (!tittle) {
        return;
    }
    
    _tittle = tittle;
    _tittleLabel.frame = CGRectMake(20.f, self.rowH/2 - 15.f, 120.f, 30.f);
    _tittleLabel.text = tittle;
    [self addSubview:_tittleLabel];
}

- (void)setInfo:(NSString *)info{
    if (!info) {
        return;
    }
    
    _info = info;
    _infoLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 260.f, self.rowH/2 - 15.f, 200.f, 30.f);
    _infoLabel.text = info;
    [self addSubview:_infoLabel];
}


-  (void)setLogoName:(NSString *)logoName{
    if (!logoName) {
        return;
    }
    
    _logoName = logoName;
    _logoImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 85.f - 60.f, self.rowH/2 - 90.f/2, 85.f, 90.f);
    if ([logoName hasSuffix:@".png"] || [logoName hasSuffix:@".jpg"]) {
        //沙盒中数据
        if ([logoName hasSuffix:@"Icon_200_200.jpg"]) {
            _logoImageView.image = [UIImage imageWithContentsOfFile:logoName];
            return ;
        }
        //网络图片
        [_logoImageView sd_setImageWithURL:[NSURL URLWithString:logoName] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }else{
        _logoImageView.image = [UIImage imageNamed:@"touxiang"];
    }
    [self addSubview:_logoImageView];
    
}




@end
