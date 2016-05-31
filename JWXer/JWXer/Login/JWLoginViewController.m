//
//  JWLoginViewController.m
//  JWXuer
//
//  Created by acher on 16/1/29.
//  Copyright (c) 2016年 acher. All rights reserved.
//

#import "JWLoginViewController.h"
#import "UIColor+HexColor.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#import "JWUserInfo.h"
#import "JWRegisterViewController.h"
#import "JWForgetPassWordViewController.h"

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define rowWidth 10.f
#define line 20.f
#define ScreenLine 30.f


@interface JWLoginViewController ()

@property (nonatomic,strong)UITextField *phone;
@property (nonatomic,strong)UITextField *password;
@property (nonatomic,strong)UIAlertController *myAlert;
@property (nonatomic,strong)UIAlertController *save;

@property (nonatomic,copy)NSString *getUserName;
@property (nonatomic,copy)NSString *getPassWord;

@property (nonatomic,copy)JWUserInfo *myInfo;

@end

@implementation JWLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_getUserName != nil) {
        _phone.text = _getUserName;
        _password.text = _getPassWord;
        [self loginTouch];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, SCREENWIDTH, SCREENHEIGHT)];
    backGround.image = [UIImage imageNamed:@"beijing"];
    
    
    CGFloat welcomeW = 196.f;
    CGFloat welcomeH = 38.f;
    CGFloat welcomeX = (SCREENWIDTH - welcomeW)/2;
    UIImageView *welcome = [[UIImageView alloc]initWithFrame:CGRectMake(welcomeX, ScreenLine, welcomeW, welcomeH)];
    welcome.image = [UIImage imageNamed:@"WELCOME"];
    
    
    CGFloat IconW = 30.f;
    CGFloat textFieldW = 215.f;
    CGFloat textFieldH = 30.f;
    CGFloat IconX = (SCREENWIDTH - IconW - textFieldW - rowWidth)/2;
    CGFloat phoneIconY = CGRectGetMaxY(welcome.frame) + line;
    UIImageView *phoneIcon = [[UIImageView alloc]initWithFrame:CGRectMake(IconX, phoneIconY, IconW, IconW)];
    phoneIcon.image = [UIImage imageNamed:@"zhanghuming"];
    
    //    CGFloat phoneX = CGRectGetMaxX(phoneIcon.frame) + row;
    CGFloat phoneX = IconX;
    _phone = [[UITextField alloc]init];
    _phone.frame = CGRectMake(phoneX, phoneIconY, textFieldW, textFieldH);
    _phone.leftView = phoneIcon;
    _phone.leftViewMode = UITextFieldViewModeAlways;
    _phone.placeholder = @"请输入手机号";
    _phone.keyboardType = UIKeyboardTypeDefault;
    _phone.clearsOnBeginEditing = YES;
    [_phone setValue:[UIColor colorWithHexString:@"#f0f0f0"] forKeyPath:@"_placeholderLabel.textColor"];//placeholder文字变成白色
    _phone.clearsOnBeginEditing = YES;//再次编辑清除内容
    
    
    //画线
    CGFloat lineShowW = SCREENWIDTH - IconX*2;
    CGFloat lineShowH = 1.f;
    CGFloat lineShowY = CGRectGetMaxY(_phone.frame) + lineShowH*2;
    UIButton * lineShow =[[UIButton alloc]initWithFrame:CGRectMake(IconX, lineShowY, lineShowW, lineShowH)];
    lineShow.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat passwordY = CGRectGetMaxY(_phone.frame) + line;
    UIImageView *passwordIcon = [[UIImageView alloc]initWithFrame:CGRectMake(IconX, passwordY, IconW, IconW)];
    passwordIcon.image = [UIImage imageNamed:@"mima"];
    
    
    _password = [[UITextField alloc]init];
    _password.frame = CGRectMake(phoneX, passwordY, textFieldW, textFieldH);
    _password.leftView = passwordIcon;
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.placeholder =@"请输入密码";
    _password.clearsOnBeginEditing = YES;
    _password.keyboardType = UIKeyboardTypeDefault;//添加键盘
    [_password setValue:[UIColor colorWithHexString:@"#f0f0f0"] forKeyPath:@"_placeholderLabel.textColor"];
    _password.secureTextEntry = YES;//密码隐藏
    
    
    //画线
    CGFloat lineShowY2 = CGRectGetMaxY(_password.frame) + lineShowH*2;
    UIButton * lineShow2 =[[UIButton alloc]initWithFrame:CGRectMake(IconX, lineShowY2, lineShowW, lineShowH)];
    lineShow2.backgroundColor = [UIColor whiteColor];
    
    
    
    //login
    CGFloat buttonW = 250.f;
    CGFloat buttonH = 40.f;
    CGFloat buttonX = (SCREENWIDTH - buttonW)/2;
    CGFloat loginY = CGRectGetMaxY(passwordIcon.frame) + line;
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, loginY, buttonW, buttonH)];
    UIImageView *loginView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, buttonW, buttonH)];
    loginView.image = [UIImage imageNamed:@"anniu"];
    UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, buttonW, buttonH)];
    loginLabel.text = @"登陆";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    [login addSubview:loginView];
    [login addSubview:loginLabel];
    [login addTarget:self action:@selector(loginTouch) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //rigisterButton
    CGFloat rigisterY = CGRectGetMaxY(login.frame) + line;
    UIButton *rigisterButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, rigisterY, buttonW, buttonH)];
    UIImageView *rigisterView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, buttonW, buttonH)];
    rigisterView.image = [UIImage imageNamed:@"zhuce-anniu"];
    UILabel *rigisterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, buttonW, buttonH)];
    rigisterLabel.text = @"注册";
    rigisterLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
    rigisterLabel.textAlignment = NSTextAlignmentCenter;
    [rigisterButton addSubview:rigisterView];
    [rigisterButton addSubview:rigisterLabel];
    [rigisterButton addTarget:self action:@selector(rigisterTouch) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * forgetPassWordButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100.f) / 2, CGRectGetMaxY(rigisterButton.frame) + line, 100.f, 20.f)];
    forgetPassWordButton.titleLabel.textColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [forgetPassWordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPassWordButton setTitle:@"忘记密码?" forState:UIControlStateHighlighted];
    [forgetPassWordButton addTarget:self action:@selector(forgetPassWordAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat logoW = 85.f;
    CGFloat logoH = 25.f;
    CGFloat logoX = (SCREENWIDTH - logoW)/2;
    CGFloat logoY = (SCREENHEIGHT - logoH*3 - line);
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(logoX, logoY, logoW, logoH)];
    logo.image = [UIImage imageNamed:@"logo"];
    
    [self.view addSubview:backGround];
    [self.view addSubview:welcome];
    //    [self.view addSubview:phoneIcon];
    [self.view addSubview:_phone];
    [self.view addSubview:lineShow];
    //    [self.view addSubview:passwordIcon];
    [self.view addSubview:_password];
    [self.view addSubview:lineShow2];
    [self.view addSubview:login];
    [self.view addSubview:rigisterButton];
    [self.view addSubview:forgetPassWordButton];
    [self.view addSubview:logo];
    
    
    
    //手势取消键盘
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];

}


#pragma mark - Button Action

- (void)loginTouch{
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }];
    
    UIAlertAction *forgetPassWord = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self forgetPassWordAction];
    }];
    //http://www.xuer.com/theapi.php?act=userlogin
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    NSString *getListURL = @"http://www.xuer.com/theapi.php?act=userlogin";
    
    //请求数组
    NSDictionary * login = @{@"username" : _phone.text ,@"password" : _password.text};
    
    [manager POST:getListURL parameters:login success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //输出响应
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSLog(@"-----------------------");
        //解码器
        JSONDecoder *decoder = [JSONDecoder decoder];
        NSDictionary * dictionaryAfterDecoder = [decoder objectWithData:responseObject];
        NSLog(@"%@",dictionaryAfterDecoder);
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~");
        
        int status = [[dictionaryAfterDecoder valueForKey:@"status"] intValue];
        
        if (status == 1) {
            _myAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户为空" preferredStyle:UIAlertControllerStyleAlert];
            [_myAlert addAction:selectAction];
            [self presentViewController:self.myAlert animated:YES completion:^{
            }];
        } else if (status == 2){
            _myAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
            [_myAlert addAction:selectAction];
            [_myAlert addAction:forgetPassWord];
            [self presentViewController:_myAlert animated:YES completion:^{
                
            }];
        } else if (status == 200){
            
            //保存&置空信息
            NSDictionary *infoDic = [dictionaryAfterDecoder valueForKey:@"data"];
            
            _myInfo = [JWUserInfo shareUserInfo];
            
            _myInfo.userID = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"id"]];
            _myInfo.userName = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"username"]];
            _myInfo.passWord = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"password"]];
            _myInfo.realName = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"realname"]];
            _myInfo.sex = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"sex"]];
            _myInfo.email = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"email"]];
            _myInfo.logo = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"logo"]];
            
            [_myInfo saveInfo];
            NSLog(@"myInfo is %@",_myInfo);
            
            _phone.text    = @"";
            _password.text = @"";
            
            //界面跳转
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}

- (void)rigisterTouch{
    JWRegisterViewController * registerViewController = [[JWRegisterViewController alloc]init];
    registerViewController.getPass = ^(NSString *rigisterUserName,NSString*rigisterPassWord){
        _getUserName = rigisterUserName;
        _getPassWord = rigisterPassWord;
    };
    [registerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:registerViewController animated:YES completion:^{
        
    }];
}

- (void)forgetPassWordAction{
    JWForgetPassWordViewController *forgetPasswordView = [[JWForgetPassWordViewController alloc]init];
    [forgetPasswordView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:forgetPasswordView animated:YES completion:^{
        
    }];
}

#pragma mark -取消第一响应
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}


#pragma mark -手势取消键盘
- (void)tapAction{
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
