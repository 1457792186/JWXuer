//
//  JWHomeCollectionViewCell.m
//  JWXer
//
//  Created by scjy on 16/2/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWHomeCollectionViewCell.h"

@implementation JWHomeCollectionViewCell

- (void)setCourseName:(NSString *)courseName{
    if (!courseName)return;
    
    if (!self.courseLabel) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        self.courseLabel = [[UILabel alloc]init];
        self.courseLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        self.courseLabel.textAlignment = NSTextAlignmentCenter;
        self.courseLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:self.courseLabel];
    }
    
    _courseName = courseName;
    _courseLabel.text = courseName;
    
}

- (void)setImageName:(NSString *)imageName{
    if (!imageName)return;
    
    _imageName = imageName;
    
    if (!self.courseImage) {
        self.courseImage = [[UIImageView alloc]init];
        [self.courseImage sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"tupian2-1"]];
        [self addSubview:self.courseImage];
    }
}


- (void)layoutSubviews{
    self.courseLabel.frame = CGRectMake(0.f, self.frame.size.height - 20.f, self.frame.size.width, 20.f);
    
    CGFloat courseButtonHeigh = self.frame.size.height - self.courseLabel.frame.size.height;
    self.courseImage.frame = CGRectMake(0.f, 0.f, self.frame.size.width, courseButtonHeigh);
}

@end
