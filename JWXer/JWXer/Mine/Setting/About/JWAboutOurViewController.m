//
//  JWAboutOurViewController.m
//  JWXer
//
//  Created by scjy on 16/2/25.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWAboutOurViewController.h"
#import "JWShareView.h"
#import "UIColor+HexColor.h"
#import "JWUserInfo.h"

#import "AFNetworking.h"
#import "JSONKit.h"
@interface JWAboutOurViewController ()

@property (nonatomic,strong)JWNavigationBarButton * mineRightBar;

@end

@implementation JWAboutOurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"关于我们";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    self.mineRightBar = [[JWNavigationBarButton alloc]init];
    self.mineRightBar.imageName = @"fenxiang";
    self.mineRightBar.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 15.f - 25.f), 30.f, 25.f, 30.f);
    [self.mineRightBar addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:self.mineRightBar];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView * imageLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth - 200.f) / 2, 30.f + NavigationBarHeigh, 200.f, 45.f)];
    imageLogoView.image = [UIImage imageNamed:@"xuerBig"];
    [self.view addSubview:imageLogoView];
    
    UIImageView * imageLineView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth - 200.f) / 2, CGRectGetMaxY(imageLogoView.frame), 200.f, 15.f)];
    imageLineView.image = [UIImage imageNamed:@"aboutImage"];
    [self.view addSubview:imageLineView];
    
    UILabel * vLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidth - 200.f) / 2, CGRectGetMaxY(imageLineView.frame), 200.f, 30.f)];
    vLabel.textAlignment = NSTextAlignmentCenter;
    vLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
    vLabel.font = [UIFont boldSystemFontOfSize:25.f];
    vLabel.text = @"V1.0";
    [self.view addSubview:vLabel];
    
    UILabel * infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.f, CGRectGetMaxY(vLabel.frame) + 15.f,screenWidth - 20.f * 2, 80.f)];
    infoLabel.numberOfLines = 0;
    infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    infoLabel.text = @"学啊网是北京尚德志远科技有限公司旗下高端在线教育产品，公司现有优势教学资源，聘请国内一线精英讲师，采用国际最先进高清视频录制技术，实现课堂真实环境的完美还原!";
    CGSize size = [infoLabel sizeThatFits:CGSizeMake(infoLabel.frame.size.width, MAXFLOAT)];
    infoLabel.frame =CGRectMake(infoLabel.frame.origin.x, infoLabel.frame.origin.y, infoLabel.frame.size.width, size.height);
    infoLabel.font = [UIFont systemFontOfSize:20.f];
    [self.view addSubview:infoLabel];
    
    UIImageView * imageWeCharShareView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth - 140.f) / 2, CGRectGetMaxY(infoLabel.frame), 140.f, 140.f)];
    imageWeCharShareView.image = [UIImage imageNamed:@"erweima"];
    [self.view addSubview:imageWeCharShareView];
    
    UILabel * vTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, [UIScreen mainScreen].bounds.size.height - 20.f - 15.f,screenWidth, 15.f)];
    vTextLabel.textAlignment = NSTextAlignmentCenter;
    vTextLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
    vTextLabel.font = [UIFont systemFontOfSize:15.f];
    vTextLabel.text = @"Copyright＠2014学啊网版权所有";
    [self.view addSubview:vTextLabel];
    
    UIButton * updateButton = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth - 120.f) / 2, (CGRectGetMaxY(imageWeCharShareView.frame) + CGRectGetMinY(vTextLabel.frame)) / 2 - 30.f, 120.f, 30.f)];
    [updateButton setImage:[UIImage imageNamed:@"gengxin"] forState:UIControlStateNormal];
    [updateButton setImage:[UIImage imageNamed:@"gengxin"] forState:UIControlStateHighlighted];
    UILabel * updateLabel = [[UILabel alloc]initWithFrame:CGRectMake((updateButton.frame.size.width - 60.f) / 2, (updateButton.frame.size.height - 15.f) / 2, 60.f, 15.f)];
    updateLabel.textAlignment = NSTextAlignmentCenter;
    updateLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
    updateLabel.font = [UIFont systemFontOfSize:15.f];
    updateLabel.text = @"检查更新";
    [updateButton addSubview:updateLabel];
    [updateButton addTarget:self action:@selector(checkUpdate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateButton];
}

- (void)checkUpdate{
    JWUserInfo * userInfo = [JWUserInfo shareUserInfo];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }];
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * typeCourseURL = @"http://www.xuer.com/theapi.php?act=checkupdate";
    NSDictionary * postDic = @{@"uid":userInfo.userID,@"myversion":@"1.0"};
    
    [manger POST:typeCourseURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
        //        NSLog(@"%@",dicTemp);
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"版本为最新" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        } else if (status == 1){
            
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户或版本id为空" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)shareButtonAction{
    JWShareView * shareVC = [[JWShareView alloc]init];
    [self.view addSubview:shareVC];
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
