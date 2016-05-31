//
//  JWSettingViewController.m
//  JWXer
//
//  Created by scjy on 16/2/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWSettingViewController.h"
#import "JWUserInfoViewController.h"
#import "JWUserInfo.h"
#import "JWSettingTableViewCell.h"
#import "JWSuggestionViewController.h"
#import "JWAboutOurViewController.h"
#import "JWGetPath.h"

#import "UIImageView+WebCache.h"

@interface JWSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)JWUserInfo * userInfo;

@property (nonatomic,copy)NSString * cacheFilePath;

@property (nonatomic,strong)NSArray * settingNameArray;
@property (nonatomic,strong)UITableView * settingTableView;
@property (nonatomic,strong)UIButton * iconButton;
@property (nonatomic,strong)UIButton * outLogin;

@end

@implementation JWSettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.userInfo = [JWUserInfo shareUserInfo];
    [self.settingTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"设置";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    self.userInfo = [[JWUserInfo alloc]init];
    self.userInfo = [JWUserInfo shareUserInfo];
    
    self.settingNameArray = @[@[@"视频下载清晰度",@"允许使用2G/3G/4G/网络观看视频",@"允许使用2G/3G/4G/网络下载视频"],@[@"意见反馈",@"给予星评",@"关于"],@[@"清除缓存",@"清除离线下载内容"]];
    
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, NavigationBarHeigh, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NavigationBarHeigh) style:UITableViewStylePlain];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;

    [self.view addSubview:self.settingTableView];
}

#pragma mark - ButtonAction
- (void)myInfoAction{
    if ([self.userInfo.userName isEqualToString:@""]) return;
    
    JWUserInfoViewController * jwUserInfoVC = [[JWUserInfoViewController alloc]init];
    [jwUserInfoVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:jwUserInfoVC animated:YES completion:^{
        
    }];
}

- (void)outLoginAction{
    self.userInfo.userName = @"";
    self.userInfo.userID   = @"";
    self.userInfo.passWord = @"";
    self.userInfo.realName = @"";
    self.userInfo.sex      = @"";
    self.userInfo.email    = @"";
    self.userInfo.logo     = @"";
    [self.userInfo saveInfo];
    NSLog(@"userID=%@",self.userInfo.userID);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)watchAVAction:(UISwitch *)watchAVSwitch{
    
}

- (void)downLoadAVAction:(UISwitch *)downLoadAVSwitch{
    
}

- (void)segementChose:(UISegmentedControl *)downLoadSegmentedControl{
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 130.f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.settingNameArray.count + 1) {
        return 80.f;
    } else if (section == 0 || section == self.settingNameArray.count){
        return 0.f;
    }
    return 20.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 130.f)];
        view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        
        self.iconButton = [[UIButton alloc]initWithFrame:CGRectMake((view.frame.size.width - 80.f) / 2, 8.f, 80.f, 80.f)];
        [self.iconButton addTarget:self action:@selector(myInfoAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.iconButton];
        
        
        UIImageView * btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.iconButton.frame.size.width, self.iconButton.frame.size.height)];
        if ([self.userInfo.userName isEqualToString:@""]) {
            btnImageView.image = [UIImage imageNamed:@"touxiang"];
            [self.iconButton addSubview:btnImageView];
        } else{
            if ([self.userInfo.logo hasSuffix:@".png"] || [self.userInfo.logo hasSuffix:@".jpg"]) {
                //沙盒中数据
                if ([self.userInfo.logo hasSuffix:@"Icon_200_200.jpg"]) {
                    btnImageView.image = [UIImage imageWithContentsOfFile:self.userInfo.logo];
                } else{
                    //网络图片
                    [btnImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.logo] placeholderImage:[UIImage imageNamed:@"touxiang"]];
                }
            } else{
                [btnImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.logo] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            }
        }
        [self.iconButton addSubview:btnImageView];
        
        UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.iconButton.frame) + 5.f, view.frame.size.width, 30.f)];
        userNameLabel.textAlignment = NSTextAlignmentCenter;
        userNameLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        userNameLabel.font = [UIFont boldSystemFontOfSize:25.f];
        if ([self.userInfo.userName isEqualToString:@""]) {
            userNameLabel.text = @
            "用户名";
        } else{
            userNameLabel.text = self.userInfo.realName;
        }
        
        [view addSubview:userNameLabel];
        
        return view;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == (self.settingNameArray.count + 1)) {
        if ([self.userInfo.userName isEqualToString:@""]) {
            return nil;
        } else{
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 80.f)];
            view.backgroundColor = [UIColor clearColor];
            self.outLogin = [[UIButton alloc]initWithFrame:CGRectMake(8.f, 20.f, [UIScreen mainScreen].bounds.size.width - 8.f * 2, 40.f)];
            [self.outLogin addTarget:self action:@selector(outLoginAction) forControlEvents:UIControlEventTouchUpInside];
            self.outLogin.backgroundColor = [UIColor colorWithHexString:@"#fe3e3c"];
            self.outLogin.layer.cornerRadius = 10.f;
            [self.outLogin setTitle:@"退出登录" forState:UIControlStateNormal];
            [self.outLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [view addSubview:self.outLogin];
            return view;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 45.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.settingNameArray.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == self.settingNameArray.count + 1) {
        return 0;
    }
    return [self.settingNameArray[section - 1] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JWSettingTableViewCell * settingCell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (!settingCell) {
        settingCell = [[JWSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"settingCell"];
    }
    
    settingCell.labelName = self.settingNameArray[indexPath.section - 1][indexPath.row];
    
    if (indexPath.section == 2) {
        UIImageView * cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(settingCell.addCellView.frame.size.width -20.f, 0.f, 20.f, settingCell.addCellView.frame.size.height)];
        cellImageView.image = [UIImage imageNamed:@"Arrow-you"];
        [settingCell.addCellView addSubview:cellImageView];
    } else if (indexPath.section == 3){
        UILabel * sourceLabel= [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, settingCell.addCellView.frame.size.width, settingCell.addCellView.frame.size.height)];
        sourceLabel.textAlignment = NSTextAlignmentRight;
        sourceLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
        sourceLabel.font = [UIFont systemFontOfSize:15.f];
        sourceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.cacheFilePath = [JWGetPath filePathWithFileName:@"CacheFile" WithFileType:FILED];
        NSLog(@"cacheFilePath is %@",self.cacheFilePath);
        NSData * cacheData = [NSData dataWithContentsOfFile:self.cacheFilePath];
        NSInteger cacheDataCount = cacheData.length/1024;
        sourceLabel.text = [NSString stringWithFormat:@"%zi MB",cacheDataCount];
        [settingCell.addCellView addSubview:sourceLabel];
    } else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UISegmentedControl * downAVSegmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"流畅",@"高清"]];
            downAVSegmentedControl.frame = CGRectMake(0.f, 0.f, settingCell.addCellView.frame.size.width, settingCell.addCellView.frame.size.height);
            downAVSegmentedControl.selectedSegmentIndex = 0;
            [downAVSegmentedControl addTarget:self action:@selector(segementChose:) forControlEvents:UIControlEventValueChanged];
            [settingCell.addCellView addSubview:downAVSegmentedControl];
        } else if (indexPath.row == 1){
            UISwitch * watchAVSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(settingCell.addCellView.frame.size.width - 50.f, 0.f, 50.f, settingCell.addCellView.frame.size.height)];
            watchAVSwitch.on = NO;
            [watchAVSwitch addTarget:self action:@selector(watchAVAction:) forControlEvents:UIControlEventValueChanged];
            [settingCell.addCellView addSubview:watchAVSwitch];
        } else if (indexPath.row == 2){
            UISwitch * downLoadAVSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(settingCell.addCellView.frame.size.width - 50.f, 0.f, 50.f, settingCell.addCellView.frame.size.height)];
            downLoadAVSwitch.on = YES;
            [downLoadAVSwitch addTarget:self action:@selector(downLoadAVAction:) forControlEvents:UIControlEventValueChanged];
            [settingCell.addCellView addSubview:downLoadAVSwitch];
        }
    }
    
    return settingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            JWSuggestionViewController * suggestionVC = [[JWSuggestionViewController alloc]init];
//            书页模式会自动在空白处添加点击回转事件
//            [suggestionVC setModalTransitionStyle:UIModalTransitionStylePartialCurl];
            [self presentViewController:suggestionVC animated:YES completion:^{
                
            }];
        } else if (indexPath.row == 2){
            JWAboutOurViewController * aboutOurVC = [[JWAboutOurViewController alloc]init];
//            [aboutOurVC setModalTransitionStyle:UIModalTransitionStylePartialCurl];
            [self presentViewController:aboutOurVC animated:YES completion:^{
                
            }];
        }
        
    }
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
