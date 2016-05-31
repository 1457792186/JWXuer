//
//  JWSearchCourseViewController.m
//  JWXer
//
//  Created by scjy on 16/2/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWSearchCourseViewController.h"
#import "JWSearchButton.h"
#import "JWSearchViewTableViewCell.h"
#import "JWUserInfo.h"
#import "JWClassficationViewController.h"

#import "AFNetworking.h"
#import "JSONKit.h"

@interface JWSearchCourseViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)JWSearchButton * searchButton;
@property (nonatomic,strong)UITableView * searchTableView;
@property (nonatomic,strong)NSMutableArray * searchArray;
@property (nonatomic,strong)JWUserInfo * userInfo;

@end

@implementation JWSearchCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchButton = [[JWSearchButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 15.f - 210.f), 30.f, 210.f, 30.f)];
    [self.searchButton.startSearchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myNavigationBar addSubview:self.searchButton];;
    self.searchButton.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchButton.searchTextField.delegate = self;
    
    self.userInfo = [JWUserInfo shareUserInfo];
    
    self.searchArray = [[NSMutableArray alloc]init];
    
    self.searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, NavigationBarHeigh, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NavigationBarHeigh) style:UITableViewStylePlain];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    [self.view addSubview:self.searchTableView];
    
}

#pragma mark - getInfo
- (void)getInfo{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * searchURL = @"http://www.xuer.com/theapi.php?act=serchlist";
    NSDictionary * postDic = @{@"taguid":self.userInfo.userID,@"keyword":self.searchButton.searchTextField.text,@"page":@"0",@"count":@"100"};
    
    [manger POST:searchURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
//        NSLog(@"%@",dicTemp);
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            [self.searchArray removeAllObjects];
            [self.searchArray addObjectsFromArray:[dicTemp valueForKey:@"data"]];
            [self.searchTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JWSearchViewTableViewCell * searchCell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    if (!searchCell) {
        searchCell = [[JWSearchViewTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"searchCell"];
    }
    NSDictionary * dateDic = self.searchArray[indexPath.row];
    searchCell.searchDic = dateDic;
    return searchCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JWClassficationViewController * classficationVC = [[JWClassficationViewController alloc]init];
    classficationVC.courseID = [self.searchArray[indexPath.row] valueForKey:@"id"];
    [self presentViewController:classficationVC animated:YES completion:^{
        
    }];
}


#pragma mark - SearchButtonAction
- (void)searchButtonAction:(JWSearchButton *)searchButton{
    [self getInfo];
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self searchButtonAction:self.searchButton];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self searchButtonAction:self.searchButton];
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
