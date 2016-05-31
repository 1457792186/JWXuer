//
//  JWSuggestionViewController.m
//  JWXer
//
//  Created by scjy on 16/2/25.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWSuggestionViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#import "JWUserInfo.h"

@interface JWSuggestionViewController ()

@property (nonatomic,strong)UITextView * commitTextView;
@property (nonatomic,strong)NSArray * quickArray;
@property (nonatomic,strong)UITapGestureRecognizer * tap;

@property (nonatomic,assign)NSInteger writeCount;
@end

@implementation JWSuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"意见反馈";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    UIButton * commitButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60.f - 15.f), 30.f, 60.f, 30.f)];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:commitButton];
    
    CGFloat endge = 10.f;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - endge * 2;
    CGFloat heigh = 30.f;
    UILabel * suggestLabel = [[UILabel alloc]initWithFrame:CGRectMake(endge, NavigationBarHeigh + endge, width, heigh)];
    suggestLabel.font = [UIFont systemFontOfSize:20.f];
    suggestLabel.text = @"反馈内容:";
    [self.view addSubview:suggestLabel];
    
    self.commitTextView = [[UITextView alloc]initWithFrame:CGRectMake(endge, CGRectGetMaxY(suggestLabel.frame), width, 105.f)];
    UIView * commitTextView = [[UIView alloc]initWithFrame:self.commitTextView.frame];
    commitTextView.backgroundColor = [UIColor whiteColor];
    self.commitTextView.keyboardType = UIKeyboardTypeDefault;
    self.commitTextView.font = [UIFont systemFontOfSize:15.f];
    self.commitTextView.text = @"感谢大家提出宝贵意见!";
    self.commitTextView.textColor = [UIColor lightGrayColor];
    [self.view addSubview:commitTextView];
    [self.view addSubview:self.commitTextView];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.commitTextView addGestureRecognizer:self.tap];
    
    
    UILabel * emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(endge, CGRectGetMaxY(self.commitTextView.frame) + endge * 2, width, heigh)];
    emailLabel.font = [UIFont systemFontOfSize:20.f];
    emailLabel.text = @"联系邮箱:";
    [self.view addSubview:emailLabel];
    
    UITextField * emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(endge, CGRectGetMaxY(emailLabel.frame), width, heigh)];
    UIView * emailTextFieldView = [[UIView alloc]initWithFrame:emailTextField.frame];
    emailTextFieldView.backgroundColor = [UIColor whiteColor];
    emailTextField.font = [UIFont systemFontOfSize:20.f];
    emailTextField.clearsOnBeginEditing = YES;
    emailTextField.placeholder = @"123456789@qq.com";
    [self.view addSubview:emailTextFieldView];
    [self.view addSubview:emailTextField];
    
    UILabel * quickLabel = [[UILabel alloc]initWithFrame:CGRectMake(endge, CGRectGetMaxY(emailTextField.frame) + endge, width, heigh)];
    quickLabel.font = [UIFont systemFontOfSize:20.f];
    quickLabel.text = @"快速反馈:";
    [self.view addSubview:quickLabel];
    
    self.quickArray = @[@"部分视频打不开",@"视频出现卡顿或者黑屏",@"部分功能操作不方便",@"无法购买课程"];
    for (int i = 0; i < self.quickArray.count; i++) {
        UIButton * btnTemp = [[UIButton alloc]initWithFrame:CGRectMake(endge, CGRectGetMaxY(quickLabel.frame) + (40.f + 1.f) * i, width, 40.f)];
        btnTemp.backgroundColor = [UIColor whiteColor];
        UILabel * btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, btnTemp.frame.size.width, btnTemp.frame.size.height)];
        btnLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        btnLabel.font = [UIFont systemFontOfSize:20.f];
        btnLabel.text = [NSString stringWithFormat:@"  %d.%@",i + 1,self.quickArray[i]];
        [btnTemp addSubview:btnLabel];
        btnTemp.tag = 300 + i;
        
        [btnTemp addTarget:self action:@selector(quickAddButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnTemp];
    }
    
    
}

- (void)tapAction{
    self.writeCount = 1;
    self.commitTextView.text = @"";
    self.commitTextView.textColor = [UIColor blackColor];
    [self.commitTextView removeGestureRecognizer:self.tap];
    [self.commitTextView becomeFirstResponder];
}

- (void)quickAddButton:(UIButton *)quickButton{
    if (self.writeCount == 0) {
        self.writeCount = 1;
        self.commitTextView.text = [NSString stringWithFormat:@"%@",self.quickArray[quickButton.tag - 300]];
        [self.commitTextView removeGestureRecognizer:self.tap];
    }
    if ([self.commitTextView.text isEqualToString:@""]) {
        self.commitTextView.text = [NSString stringWithFormat:@"%@",self.quickArray[quickButton.tag - 300]];
        return;
    }
    self.commitTextView.text = [NSString stringWithFormat:@"%@;%@",self.commitTextView.text,self.quickArray[quickButton.tag - 300]];
}

- (void)commitButtonAction{
    JWUserInfo * userInfo = [JWUserInfo shareUserInfo];
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * typeCourseURL = @"http://www.xuer.com/theapi.php?act=yijian";
    NSDictionary * postDic = @{@"uid":userInfo.userID,@"content":self.commitTextView};
    
    [manger POST:typeCourseURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
        //        NSLog(@"%@",dicTemp);
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }];
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"谢谢" message:@"感谢反馈" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        } else if (status == 1){
            UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
            }];
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户或内容为空" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
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
