//
//  JWCourseCollectionViewCell.m
//  JWXer
//
//  Created by scjy on 16/2/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWCourseCollectionViewCell.h"

@implementation JWCourseCollectionViewCell


#pragma mark - SetProperty

- (void)setCourseName:(NSString *)courseName{
    if (!courseName)return;
    
    _courseName = courseName;
    if (!self.courseLabel) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        self.courseLabel = [[UILabel alloc]init];
        self.courseLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        self.courseLabel.textAlignment = NSTextAlignmentCenter;
        self.courseLabel.font = [UIFont systemFontOfSize:13.f];
        self.courseLabel.numberOfLines = 1;
        self.courseLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:self.courseLabel];
        
        _courseLabel.text = courseName;
    }
    
}

- (void)setCourseImage:(NSString *)courseImage{
    if (!courseImage)return;
    
    _courseImage = courseImage;
    
    if (!self.courseImageView) {
        self.courseImageView = [[UIImageView alloc]init];
        [self.courseImageView sd_setImageWithURL:[NSURL URLWithString:courseImage] placeholderImage:[UIImage imageNamed:@"tupian1"]];
        [self addSubview:self.courseImageView];
    }
}


- (void)layoutSubviews{
    self.courseLabel.frame = CGRectMake(0.f, self.frame.size.height - 20.f, self.frame.size.width, 20.f);
    
    CGFloat courseButtonHeigh = self.frame.size.height - self.courseLabel.frame.size.height;
    CGFloat courseButtonEdge = (self.frame.size.width - courseButtonHeigh) / 2;
    self.courseImageView.frame = CGRectMake(courseButtonEdge, 0.f, courseButtonHeigh, courseButtonHeigh);
    
    
}

@end
