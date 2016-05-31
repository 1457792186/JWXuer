//
//  JWNavigationController.h
//  JWXuer
//
//  Created by acher on 16/1/29.
//  Copyright (c) 2016年 acher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWNavigationBarButton.h"
#import "JWNavigationBarLabel.h"
#import "JWNavigationBar.h"

extern const CGFloat line;
extern const CGFloat ScreenLine;

@interface JWNavigationController : UIViewController

@property (nonatomic,strong)JWNavigationBar * myNavigationBar;
@property (nonatomic,strong)JWNavigationBarButton * leftBar;
@property (nonatomic,strong)JWNavigationBarLabel * tittleLabel;

@property (nonatomic,assign)BOOL hideNavigationbar;
@property (nonatomic,assign)BOOL showLeftButton;

- (void)hideNavigationbarChange;
- (void)showLeftButtonChange;

@end
