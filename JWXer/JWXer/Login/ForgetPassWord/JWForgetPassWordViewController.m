//
//  JWForgetPassWordViewController.m
//  JWXer
//
//  Created by scjy on 16/2/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWForgetPassWordViewController.h"
#import "UITextField+RigisterViewCreate.h"

@interface JWForgetPassWordViewController ()
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UITextField *passWordTextField;
@property (nonatomic,strong)UITextField *captchaTextField;//验证码

@end

@implementation JWForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"忘记密码";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    CGFloat SCREENWIDTH = [UIScreen mainScreen].bounds.size.width;
    CGFloat rowWidth = 10.f;
    CGFloat ControlHigh = 60.f;
    
    _phoneTextField = [UITextField initRigisterViewTextFieldX:0.f withY:(NavigationBarHeigh + rowWidth) withW:SCREENWIDTH withH:ControlHigh withText:@"  请输入手机号"];
    _phoneTextField.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    _passWordTextField = [UITextField initRigisterViewTextFieldX:0.f withY:(CGRectGetMaxY(_phoneTextField.frame) + rowWidth) withW:SCREENWIDTH withH:ControlHigh withText:@"  请输入新密码"];
    _passWordTextField.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    CGFloat buttonW = 128.f;
    UIButton * buttonLog = [[UIButton alloc]initWithFrame:CGRectMake((SCREENWIDTH - buttonW), (CGRectGetMaxY(_passWordTextField.frame) + rowWidth), buttonW, ControlHigh)];
    UILabel *buttonText = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, buttonW, ControlHigh)];
    buttonText.text = @"获取验证码";
    buttonText.textColor = [UIColor colorWithHexString:@"#46948a"];
    buttonText.textAlignment = NSTextAlignmentCenter;
    buttonText.font = [UIFont systemFontOfSize:20.f];
    [buttonLog addSubview:buttonText];
    buttonLog.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [buttonLog addTarget:self action:@selector(getCaptcha) forControlEvents:UIControlEventTouchUpInside];
    
    
    _captchaTextField = [UITextField initRigisterViewTextFieldX:0.f withY:(CGRectGetMaxY(_passWordTextField.frame) + rowWidth) withW:(SCREENWIDTH - buttonW - 2.f) withH:ControlHigh withText:@"  请输入验证码"];
    _captchaTextField.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    
    [self.view addSubview:_phoneTextField];
    [self.view addSubview:_passWordTextField];
    [self.view addSubview:_captchaTextField];
    [self.view addSubview:buttonLog];
    
    UIButton * buttonFinish = [[UIButton alloc]initWithFrame:CGRectMake(line, (CGRectGetMaxY(_captchaTextField.frame) + rowWidth * 2),SCREENWIDTH - line * 2, ControlHigh)];
    UILabel *buttonFinishText = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, SCREENWIDTH - line * 2, ControlHigh)];
    buttonFinishText.text = @"完成";
    buttonFinishText.textColor = [UIColor colorWithHexString:@"#ffffff"];
    buttonFinishText.textAlignment = NSTextAlignmentCenter;
    buttonFinishText.font = [UIFont systemFontOfSize:20.f];
    [buttonFinish addSubview:buttonFinishText];
    buttonFinish.backgroundColor = [UIColor colorWithHexString:@"#46948a"];
    [buttonFinish addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    //设置圆角
    buttonFinish.layer.cornerRadius = 16.f;
    
    
    [self.view addSubview:buttonFinish];
    
}

//点击获取验证码
- (void)getCaptcha{
    
}

//点击完成
- (void)finish{
    
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
