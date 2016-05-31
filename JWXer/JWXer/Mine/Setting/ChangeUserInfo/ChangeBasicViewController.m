//
//  ChangeBasicViewController.m
//  登陆界面
//
//  Created by scjy on 16/1/16.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "ChangeBasicViewController.h"


@interface ChangeBasicViewController ()

@end

@implementation ChangeBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * saveButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60.f - 15.f), 30.f, 60.f, 30.f)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(changeInfoSave) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:saveButton];
    
   
}

- (void)changeInfoSave{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
