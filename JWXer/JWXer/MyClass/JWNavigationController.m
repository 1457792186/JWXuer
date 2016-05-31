//
//  JWNavigationController.m
//  JWXuer
//
//  Created by acher on 16/1/29.
//  Copyright (c) 2016年 acher. All rights reserved.
//

#import "JWNavigationController.h"
#import "UIColor+HexColor.h"



const CGFloat line = 20.f;
const CGFloat ScreenLine = 30.f;

@interface JWNavigationController ()

@end

@implementation JWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    
    self.hideNavigationbar = NO;
    
    self.showLeftButton = YES;
    
    self.myNavigationBar = [[JWNavigationBar alloc]init];
    
    self.leftBar = [[JWNavigationBarButton alloc]init];
    self.leftBar.imageName = @"Arrow";
    [self.leftBar addTarget:self action:@selector(touchBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:self.leftBar];
    
    
    [self.view addSubview:self.myNavigationBar];
    
}


#pragma mark - ButtonAction

- (void)touchBackAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




#pragma mark - MyFunction
- (void)hideNavigationbarChange{
    self.hideNavigationbar = YES;
    self.myNavigationBar.hidden = YES;
}

- (void)showLeftButtonChange{
    self.showLeftButton = YES;
    self.leftBar.hidden = NO;
}

#pragma mark -取消第一响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
