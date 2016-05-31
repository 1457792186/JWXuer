//
//  JWDownLoadViewController.m
//  JWXer
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWDownLoadViewController.h"
#import "UIColor+HexColor.h"

@interface JWDownLoadViewController ()

@end

@implementation JWDownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"下载";
    [self.myNavigationBar addSubview:self.tittleLabel];
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
