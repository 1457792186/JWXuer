//
//  ChangeNameViewController.m
//  登陆界面
//
//  Created by scjy on 16/1/16.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "ChangeNameViewController.h"

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"修改昵称";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    _myTextField = [UITextField initRigisterViewTextFieldX:20.f withY:(NavigationBarHeigh + 10.f) withW:([UIScreen mainScreen].bounds.size.width - 40.f) withH:60.f];
    [_myTextField setValue:[UIColor colorWithHexString:@"#46948a"] forKeyPath:@"_placeholderLabel.textColor"];
    _myTextField.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _myTextField.font = [UIFont systemFontOfSize:20.f];
    self.myTextField.placeholder = @"昵称";
    
    [self.view addSubview:_myTextField];
    
}

- (void)changeInfoSave{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getInfoWithInfo:withTag:)]) {
        [self.delegate getInfoWithInfo:self.myTextField.text withTag:1001];
    }
    self.myTextField.text = @"";
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
