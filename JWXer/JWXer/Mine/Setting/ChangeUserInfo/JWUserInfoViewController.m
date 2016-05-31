//
//  JWUserInfoViewController.m
//  JWXer
//
//  Created by scjy on 16/2/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWUserInfoViewController.h"
#import "JWUserInfo.h"
#import "UserInfoTableViewCell.h"
#import "ChangeNameViewController.h"
#import "ChangeIconViewController.h"

#import "JSONKit.h"
#import "AFNetworking.h"

const CGFloat cellHeigh = 90.f;
const CGFloat iconCellHeigh = 120.f;

@interface JWUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,ChangeInfo>

@property (nonatomic,strong)UITableView * userInfoTableView;
@property (nonatomic,strong)JWUserInfo * userInfo;

@property (nonatomic,strong)UIAlertController * myAlertController;


@end

@implementation JWUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"个人资料";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    UIButton * saveButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60.f - 15.f), 30.f, 60.f, 30.f)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:saveButton];
    
    _userInfo = [JWUserInfo shareUserInfo];
    
    _userInfoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, NavigationBarHeigh, [UIScreen mainScreen].bounds.size.width,iconCellHeigh + cellHeigh * 3) style:UITableViewStylePlain];
    //将tableView的分割线给去掉
    _userInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _userInfoTableView.delegate = self;
    _userInfoTableView.dataSource = self;
    
    
    [self.view addSubview:_userInfoTableView];
    
}

#pragma mark - GetInfoDelegate
- (void)getInfoWithInfo:(NSString *)info withTag:(NSInteger)viewControllerTag{
    if (!info)return;
    
    if (viewControllerTag == 1001) {
        _userInfo.realName = info;
        [_userInfoTableView reloadData];
    } else if (viewControllerTag == 1002){
        _userInfo.logo = info;
        [_userInfoTableView reloadData];
    }
}


- (void)saveInfo{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * changeInfoURL = @"http://www.xuer.com/theapi.php?act=useredit";
    
    NSDictionary * parameterDic = @{@"id":_userInfo.userID,@"username":_userInfo.userName,@"password":_userInfo.passWord,@"realname":_userInfo.realName,@"sex":_userInfo.sex,@"email":_userInfo.email,@"img":[NSURL fileURLWithPath:_userInfo.logo]};
    
    [manger POST:changeInfoURL parameters:parameterDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
//        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        JSONDecoder * decoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [decoder objectWithData:responseObject];
        int state = [[dicTemp valueForKey:@"status"] intValue];
        
        UIAlertAction * fixAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        
        if (state == 1) {
            _myAlertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户名为空" preferredStyle:UIAlertControllerStyleAlert];
            [_myAlertController addAction:fixAction];
            [self presentViewController:_myAlertController animated:YES completion:^{
                
            }];
        }else if (state == 2){
            _myAlertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户名不存在" preferredStyle:UIAlertControllerStyleAlert];
            [_myAlertController addAction:fixAction];
            [self presentViewController:_myAlertController animated:YES completion:^{
                
            }];
        }else if (state == 200){
            _myAlertController = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
            [_myAlertController addAction:fixAction];
            [self presentViewController:_myAlertController animated:YES completion:^{
                [self.userInfo saveInfo];
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoTableViewCell * jwCell = [tableView dequeueReusableCellWithIdentifier:@"jwCell"];
    
    if (!jwCell) {
        jwCell = [[UserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"jwCell"];
    }
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        jwCell.rowH = 90.f;
        jwCell.tittle = @"当前账号";
        jwCell.info = _userInfo.userID;
        jwCell.infoLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - jwCell.infoLabel.frame.size.width - 20.f, jwCell.infoLabel.frame.origin.y, jwCell.infoLabel.frame.size.width, jwCell.infoLabel.frame.size.height);
        return jwCell;
    }
    
    if (indexPath.row == 1 && indexPath.section == 0) {
        jwCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        jwCell.rowH = 120.f;
        jwCell.tittle = @"头像";
        jwCell.logoName = _userInfo.logo;
        
    }else if (indexPath.row == 2 && indexPath.section == 0){
        jwCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        jwCell.rowH = 90.f;
        jwCell.tittle = @"昵称";
        jwCell.info = _userInfo.realName;
        
    }else{
        jwCell.rowH = 90.f;
        jwCell.tittle = @"性别";
        if ([_userInfo.sex isEqualToString:@"0"]) {
            jwCell.info = @"男";
        }else{
            jwCell.info = @"女";
        }
    }
    
    return jwCell;
}



#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 120.f;
    }
    return 90.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.row == 1 && indexPath.section == 0) {
        ChangeIconViewController * changeIconView = [[ChangeIconViewController alloc]init];
        changeIconView.delegate = self;
        changeIconView.hidesBottomBarWhenPushed = YES;//隐藏TabBar
        [changeIconView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:changeIconView animated:YES completion:^{
            
        }];
        
    }else if (indexPath.row == 2 && indexPath.section == 0){
        ChangeNameViewController * changeNameView = [[ChangeNameViewController alloc]init];
        changeNameView.delegate = self;
        changeNameView.hidesBottomBarWhenPushed = YES;
        [changeNameView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:changeNameView animated:YES completion:^{
            
        }];
        
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
