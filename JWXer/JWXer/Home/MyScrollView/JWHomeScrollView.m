//
//  JWHomeScrollView.m
//  JWXer
//
//  Created by scjy on 16/2/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWHomeScrollView.h"

@implementation JWHomeScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame withImagesArray:(NSMutableArray *)imagesNameArray{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        
        self.bounces = NO;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        [self setContentOffset:CGPointMake(self.frame.size.width, 0.f)];
        self.backgroundColor = [UIColor blueColor];
        
        self.imagesNameArray = [NSArray arrayWithArray:imagesNameArray];
        
        self.imagesArray = [[NSMutableArray alloc]init];
        [self imagesArrayAdd];
        
    }
    return self;
}

- (void)viewGetImagesView{
    UIImageView * currentImageView = self.imagesArray[0];
    [self.currentView addSubview:currentImageView];
    
    //更新完图片后，重置位置
    [self setContentOffset:CGPointMake(self.frame.size.width, 0.f) animated:NO];
    
    UIImageView * laterImageView = self.imagesArray[1];
    [self.laterView addSubview:laterImageView];
    
    UIImageView * beyoundImageView = [self.imagesArray lastObject];
    [self.beyoundView addSubview:beyoundImageView];
    
}


- (void)imagesArrayAdd{
    self.currentBannerCount = 0;
    
    for (NSString * imageURL in self.imagesNameArray) {
        UIImageView * imageViewTemp = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        [imageViewTemp sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"banner"]];
        [self.imagesArray addObject:imageViewTemp];
    }
    
    
    //建3个视图放图片
    self.beyoundView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    self.beyoundView.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.beyoundView];
    self.currentView = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.beyoundView.frame), 0.f, self.frame.size.width, self.frame.size.height)];
    self.currentView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.currentView];
    self.laterView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.currentView.frame), 0.f, self.frame.size.width, self.frame.size.height)];
    self.laterView.backgroundColor = [UIColor redColor];
    [self addSubview:self.laterView];
    
    [self viewGetImagesView];
    
}

- (void)leftShift{
    self.currentBannerCount--;
    if (self.currentBannerCount < 0) {
        self.currentBannerCount = [self.imagesNameArray count] - 1;
    }
    
    UIImageView * imageViewTemp = [self.imagesArray lastObject];
    
    [self.imagesArray removeLastObject];
    [self.imagesArray insertObject:imageViewTemp atIndex:0];
    
    [self viewGetImagesView];
}

- (void)rightShift{
    self.currentBannerCount++;
    if (self.currentBannerCount >= self.imagesNameArray.count) {
        self.currentBannerCount = 0;
    }
    
    UIImageView * imageViewTemp = [self.imagesArray firstObject];
    
    [self.imagesArray removeObjectAtIndex:0];
    [self.imagesArray addObject:imageViewTemp];
    
    [self viewGetImagesView];
    
}


@end
