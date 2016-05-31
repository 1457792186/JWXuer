//
//  JWCourseHeaderCollectionReusableView.m
//  JWXer
//
//  Created by scjy on 16/2/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWCourseHeaderCollectionReusableView.h"

@implementation JWCourseHeaderCollectionReusableView

- (void)setTypeTittle:(NSString *)typeTittle{
    if (!typeTittle)return;
    
    _typeTittle = typeTittle;
    if (!self.typeTittleLabel) {
        UIImageView * headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, self.frame.size.height / 4, self.frame.size.height / 2, self.frame.size.height / 2)];
        headerImageView.image = [UIImage imageNamed:@"yuan2"];
        [self addSubview:headerImageView];
        
        self.typeTittleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImageView.frame), 0.f, self.frame.size.width - 10.f * 2 - headerImageView.frame.size.width, self.frame.size.height)];
        self.typeTittleLabel.text = typeTittle;
        self.typeTittleLabel.textAlignment = NSTextAlignmentLeft;
        self.typeTittleLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        self.typeTittleLabel.font = [UIFont boldSystemFontOfSize:20.f];
        [self addSubview:self.typeTittleLabel];
    }
}

@end
