//
//  JWRegisterViewController.m
//  JWXer
//
//  Created by scjy on 16/2/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWRegisterViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "JWUserInfo.h"
#import "UILabel+RigisterViewCreate.h"
#import "UITextField+RigisterViewCreate.h"

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface JWRegisterViewController (){
    NSTimer * timer;
}

@property (nonatomic,strong)UIAlertController *rigisterAlert;
@property (nonatomic,strong)UITextField * userNameTextField;
@property (nonatomic,strong)UITextField * passWordTextField;
@property (nonatomic,strong)UITextField * realNameTextField;
@property (nonatomic,strong)UITextField * sexTextField;
@property (nonatomic,strong)UITextField * emailTextField;
@property (nonatomic,strong)UITextField * imgTextField;

@end

@implementation JWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"注册";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    CGFloat buttonW = 80.f;
    CGFloat buttonH = 30.f;
    CGFloat textFieldW = SCREENWIDTH - line - ScreenLine*2 - buttonW;
    CGFloat textFieldH = 30.f;
    
    CGFloat buttonX = ScreenLine;
    CGFloat buttonY = ScreenLine + NavigationBarHeigh;
    
    CGFloat buttonAdd = (SCREENHEIGHT - buttonY * 2)/6;
    
    CGFloat textFieldX = buttonX + buttonW;
    CGFloat textFieldY = buttonY;
    
    UILabel *userNameLabel = [UILabel initRigisterViewLabelX:buttonX withY:buttonY withW:buttonW withH:buttonH withText:@"用户名:"];
    [self.view addSubview:userNameLabel];
    
    _userNameTextField = [UITextField initRigisterViewTextFieldX:textFieldX withY:textFieldY withW:textFieldW withH:textFieldH withText:@"请输入用户名"];
    [self.view addSubview:_userNameTextField];
    
    
    buttonY += buttonAdd;
    textFieldY = buttonY;
    
    UILabel *passWordLabel = [UILabel initRigisterViewLabelX:buttonX withY:buttonY withW:buttonW withH:buttonH withText:@"密码:"];
    [self.view addSubview:passWordLabel];
    
    _passWordTextField = [UITextField initRigisterViewTextFieldX:textFieldX withY:textFieldY withW:textFieldW withH:textFieldH withText:@"请输入密码"];
    _passWordTextField.secureTextEntry = YES;
    [self.view addSubview:_passWordTextField];
    
    
    buttonY += buttonAdd;
    textFieldY = buttonY;
    
    UILabel *realNameLabel = [UILabel initRigisterViewLabelX:buttonX withY:buttonY withW:buttonW withH:buttonH withText:@"昵称:"];
    [self.view addSubview:realNameLabel];
    
    _realNameTextField = [UITextField initRigisterViewTextFieldX:textFieldX withY:textFieldY withW:textFieldW withH:textFieldH withText:@"请输入昵称"];
    [self.view addSubview:_realNameTextField];
    
    
    buttonY += buttonAdd;
    textFieldY = buttonY;
    
    UILabel *sexLabel = [UILabel initRigisterViewLabelX:buttonX withY:buttonY withW:buttonW withH:buttonH withText:@"性别:"];
    [self.view addSubview:sexLabel];
    
    _sexTextField = [UITextField initRigisterViewTextFieldX:textFieldX withY:textFieldY withW:textFieldW withH:textFieldH withText:@"请输入性别(男/女)"];
    [self.view addSubview:_sexTextField];
    
    
    buttonY += buttonAdd;
    textFieldY = buttonY;
    
    UILabel *emailLabel = [UILabel initRigisterViewLabelX:buttonX withY:buttonY withW:buttonW withH:buttonH withText:@"邮箱:"];
    [self.view addSubview:emailLabel];
    
    _emailTextField = [UITextField initRigisterViewTextFieldX:textFieldX withY:textFieldY withW:textFieldW withH:textFieldH withText:@"请输入邮箱"];
    [self.view addSubview:_emailTextField];
    
    
    buttonY += buttonAdd;
    textFieldY = buttonY;
    
    UILabel *imgLabel = [UILabel initRigisterViewLabelX:buttonX withY:buttonY withW:buttonW withH:buttonH withText:@"图片:"];
    [self.view addSubview:imgLabel];
    
    _imgTextField = [UITextField initRigisterViewTextFieldX:textFieldX withY:textFieldY withW:textFieldW withH:textFieldH withText:@"请添加图片"];
    [self.view addSubview:_imgTextField];
    
    
    
    CGFloat selectButtonX = SCREENWIDTH/2 - buttonW/2;
    CGFloat selectButtonY = (SCREENHEIGHT + CGRectGetMaxY(imgLabel.frame))/2;
    
    UIButton *selectButton = [[UIButton alloc]initWithFrame:CGRectMake(selectButtonX, selectButtonY, buttonW, buttonH)];
    UILabel *selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, buttonW, buttonH)];
    selectLabel.text = @"确定";
    selectLabel.textAlignment = NSTextAlignmentCenter;
    [selectButton addSubview:selectLabel];
    [selectButton addTarget:self action:@selector(rigisterNew) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:selectButton];
    
    
}

#pragma mark-rigisterNew
- (void)rigisterNew{
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }];
    
    UIAlertAction *viewAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [timer invalidate];//停止计时器
        [self actionSuccess];
    }];
    
    if ([_realNameTextField.text isEqualToString:@""]) {
        _rigisterAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"昵称不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [_rigisterAlert addAction:selectAction];
        [self presentViewController:self.rigisterAlert animated:YES completion:^{
        }];
    }
    
    
    //http://www.xuer.com/theapi.php?act=is_reg
    //http://www.xuer.com/theapi.php?act=userins
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    NSString *getListURL = @"http://www.xuer.com/theapi.php?act=is_reg";
    
    //请求数组
    NSDictionary * rigister = @{@"username" : _userNameTextField.text};
    
    [manager POST:getListURL parameters:rigister success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //输出响应
        //解码器
        JSONDecoder *decoder = [JSONDecoder decoder];
        NSDictionary * dictionaryAfterDecoder = [decoder objectWithData:responseObject];
        NSLog(@"%@",dictionaryAfterDecoder);
        
        int status = [[dictionaryAfterDecoder valueForKey:@"status"] intValue];
        if (status == 1) {
            _rigisterAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户为空" preferredStyle:UIAlertControllerStyleAlert];
            [_rigisterAlert addAction:selectAction];
            [self presentViewController:self.rigisterAlert animated:YES completion:^{
            }];
        } else if (status == 2){
            _rigisterAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
            [_rigisterAlert addAction:selectAction];
            [self presentViewController:_rigisterAlert animated:YES completion:^{
                
            }];
        } else if (status == 200){
            
            AFHTTPRequestOperationManager *rigisterManager = [AFHTTPRequestOperationManager manager];
            rigisterManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            rigisterManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
            
            NSString *rigisterManagerGetListURL = @"http://www.xuer.com/theapi.php?act=userins";
            
            //请求数组
            //性别男0女1
            NSString * sex;
            if ([_sexTextField.text  isEqual: @"男"]) {
                sex = @"0";
            }else{
                sex = @"1";
            }
            
            NSDictionary * rigisterDic = @{@"username" : _userNameTextField.text ,@"password" : _passWordTextField.text,@"realname" : _realNameTextField.text ,@"sex" : sex ,@"email" : _emailTextField.text ,@"img" : _imgTextField.text };
            
            [rigisterManager POST:rigisterManagerGetListURL parameters:rigisterDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //输出响应
                //解码器
                NSDictionary * rigisterDictionaryAfterDecoder = [decoder objectWithData:responseObject];
                NSLog(@"%@",rigisterDictionaryAfterDecoder);
                
                int rigisterStatus = [[rigisterDictionaryAfterDecoder valueForKey:@"status"] intValue];
                if (rigisterStatus == 1 || rigisterStatus == 2) {
                    _rigisterAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert];
                    [_rigisterAlert addAction:selectAction];
                    [self presentViewController:self.rigisterAlert animated:YES completion:^{
                    }];
                } else if (rigisterStatus == 200){
                    
                    NSDictionary *infoDic = [rigisterDictionaryAfterDecoder valueForKey:@"data"];
                    
                    JWUserInfo *myInfo = [JWUserInfo shareUserInfo];
                    
                    myInfo.userID = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"id"]];
                    myInfo.userName = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"username"]];
                    myInfo.passWord = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"password"]];
                    myInfo.realName = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"realname"]];
                    myInfo.sex = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"sex"]];
                    myInfo.email = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"email"]];
                    myInfo.logo = [NSString stringWithFormat:@"%@",[infoDic valueForKey:@"logo"]];
                    
                    NSLog(@"myInfo is %@",myInfo);
                  
                    _rigisterAlert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                    [_rigisterAlert addAction:viewAction];
                    
                    [self presentViewController:self.rigisterAlert animated:YES completion:^{
                        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(actionTimerSuccess) userInfo:nil repeats:NO];
                        
                    }];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
                
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)actionSuccess{
    self.getPass(_userNameTextField.text,_passWordTextField.text);
    _userNameTextField.text = @"";
    _passWordTextField.text = @"";
    _realNameTextField.text = @"";
    _sexTextField.text      = @"";
    _emailTextField.text    = @"";
    _imgTextField.text      = @"";
    
    //跳转界面
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)actionTimerSuccess{
    self.getPass(_userNameTextField.text,_passWordTextField.text);
    _userNameTextField.text = @"";
    _passWordTextField.text = @"";
    _realNameTextField.text = @"";
    _sexTextField.text      = @"";
    _emailTextField.text    = @"";
    _imgTextField.text      = @"";
    
    //警告框消失
    [_rigisterAlert dismissViewControllerAnimated:YES completion:^{
        
    }];
    //跳转界面
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
