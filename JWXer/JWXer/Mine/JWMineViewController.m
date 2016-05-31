//
//  JWMineViewController.m
//  JWXer
//
//  Created by scjy on 16/2/17.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWMineViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#import "JWUserInfo.h"
#import "JWBeforeLoginView.h"
#import "JWMyCourseView.h"
#import "JWMyCourseTableViewCell.h"
#import "JWMyMessageView.h"
#import "JWMyMessageTableViewCell.h"

#import "JWLoginViewController.h"
#import "JWSettingViewController.h"
#import "JWClassficationViewController.h"
#import "JWDownLoadViewController.h"

@interface JWMineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)JWNavigationBarButton * mineLeftBar;
@property (nonatomic,strong)JWNavigationBarButton * mineRightBar;
@property (nonatomic,strong)UISegmentedControl * mineSegmentedController;

@property (nonatomic,strong)JWUserInfo * userInfo;

@property (nonatomic,strong)JWMyCourseView * myCourseView;
@property (nonatomic,strong)JWMyMessageView * myMessageView;
@property (nonatomic,assign)NSInteger currentPageNumber;

@property (nonatomic,strong)NSArray * myCourseArray;

@end

@implementation JWMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.userInfo.userID isEqualToString:@""]) {
        JWBeforeLoginView * beforeLoginView = [[JWBeforeLoginView alloc]init];
        [beforeLoginView.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:beforeLoginView];
    }
    
    if (![self.userInfo.userID isEqualToString:@""]) {
        self.userInfo = [JWUserInfo shareUserInfo];
        [self getCourseInfo];
        [self.view addSubview:self.myCourseView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftBar.hidden = YES;
    
    self.mineLeftBar = [[JWNavigationBarButton alloc]init];
    self.mineLeftBar.imageName = @"shezhi";
    [self.mineLeftBar addTarget:self action:@selector(settingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:self.mineLeftBar];
    
    
    self.mineRightBar = [[JWNavigationBarButton alloc]init];
    self.mineRightBar.imageName = @"xiazai";
    self.mineRightBar.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 15.f - 25.f), 30.f, 25.f, 30.f);
    [self.mineRightBar addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:self.mineRightBar];
    
    self.mineSegmentedController = [[UISegmentedControl alloc]initWithItems:@[@"我的课程",@"我的消息"]];
    self.mineSegmentedController.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 196.f)/2, 30.f, 196.f, 30.f);
    self.mineSegmentedController.tintColor = [UIColor colorWithHexString:@"#ffffff"];
    self.mineSegmentedController.selectedSegmentIndex = 0;
    [self.mineSegmentedController addTarget:self action:@selector(segementChose:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.myNavigationBar addSubview:self.mineSegmentedController];
    
    self.userInfo = [JWUserInfo shareUserInfo];

    self.currentPageNumber = 0;
    
    //添加子View
    self.myCourseView = [[JWMyCourseView alloc]init];
    self.myCourseView.myCourseTableView.delegate = self;
    self.myCourseView.myCourseTableView.dataSource = self;
    [self.view addSubview:self.myCourseView];
    
    self.myMessageView = [[JWMyMessageView alloc]init];
    [self.view addSubview:self.myMessageView];
    
}

#pragma mark - GetInfo
- (void)getCourseInfo{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    NSString * courseURL = @"http://www.xuer.com/theapi.php?act=courselist";
    
    [manger POST:courseURL parameters:@{@"uid":self.userInfo.userID,@"taguid":self.userInfo.userID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        JSONDecoder * courseJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dataDicTemp = [courseJsonDecoder objectWithData:responseObject];
//                NSLog(@"%@",dataDicTemp);
        NSInteger status = [[dataDicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            self.myCourseArray = [dataDicTemp valueForKey:@"data"];
            [self.myCourseView.myCourseTableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myCourseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JWMyCourseTableViewCell * myCourseTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"yCourseTableViewCell"];
    if (!myCourseTableViewCell) {
        myCourseTableViewCell = [[JWMyCourseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"yCourseTableViewCell"];
    }
    NSDictionary * dateDic = self.myCourseArray[indexPath.row];
    myCourseTableViewCell.courseDic = dateDic;
    
    return myCourseTableViewCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JWClassficationViewController * classficationVC = [[JWClassficationViewController alloc]init];
    classficationVC.courseID = [self.myCourseArray[indexPath.row] valueForKey:@"id"];
    [classficationVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:classficationVC animated:YES completion:^{
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105.f;
}

#pragma mark - SegementedControllerAction
- (void)segementChose:(UISegmentedControl *)segementTemp{
    NSInteger segementIndex = segementTemp.selectedSegmentIndex;
    NSLog(@"%ld",(long)segementIndex);
    
    if ([self.userInfo.userName isEqualToString:@""])return;
    
    if (self.currentPageNumber == segementIndex) {
        return;
    }else if (self.currentPageNumber == 0){
        self.currentPageNumber = 1;
        [self.myCourseView removeFromSuperview];
        [self.view addSubview:self.myMessageView];
    }else{
        self.currentPageNumber = 0;
        [self.myMessageView removeFromSuperview];
        [self getCourseInfo];
        [self.view addSubview:self.myCourseView];
    }
    
    
}


#pragma mark - ButtonAction
- (void)loginAction{
    JWLoginViewController * loginViewController = [[JWLoginViewController alloc]init];
    loginViewController.hidesBottomBarWhenPushed = YES;
    [self presentViewController:loginViewController animated:YES completion:^{
        
    }];
}

- (void)settingButtonAction{

    JWSettingViewController * jwSettingVC = [[JWSettingViewController alloc]init];
    jwSettingVC.hidesBottomBarWhenPushed = YES;
    [jwSettingVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:jwSettingVC animated:YES completion:^{
        
    }];
    
}

- (void)downloadAction{
    JWDownLoadViewController * downLoadViewController = [[JWDownLoadViewController alloc]init];
    downLoadViewController.hidesBottomBarWhenPushed = YES;
    [self presentViewController:downLoadViewController animated:YES completion:^{
        
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
