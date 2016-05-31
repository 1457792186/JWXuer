//
//  JWTypeCourseViewController.m
//  JWXer
//
//  Created by scjy on 16/2/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWTypeCourseViewController.h"

#import "JWSearchButton.h"
#import "JWSearchViewTableViewCell.h"
#import "JWUserInfo.h"
#import "JWClassficationViewController.h"
#import "JWSearchViewTableViewCell.h"

#import "AFNetworking.h"
#import "JSONKit.h"


@interface JWTypeCourseViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * typeCourseTableView;
@property (nonatomic,strong)NSMutableArray * typeCourseArray;
@property (nonatomic,strong)JWUserInfo * userInfo;

@end

@implementation JWTypeCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"课程列表";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    self.userInfo = [JWUserInfo shareUserInfo];
    
    self.typeCourseArray = [[NSMutableArray alloc]init];
    
    self.typeCourseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, NavigationBarHeigh, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NavigationBarHeigh) style:UITableViewStylePlain];
    self.typeCourseTableView.delegate = self;
    self.typeCourseTableView.dataSource = self;
    [self.view addSubview:self.typeCourseTableView];
    
    [self getInfo];
}

#pragma mark - getInfo
- (void)getInfo{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * typeCourseURL = @"http://www.xuer.com/theapi.php?act=courselist";
    NSDictionary * postDic = @{@"arrchildid":self.courseID};
    
    [manger POST:typeCourseURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
//        NSLog(@"%@",dicTemp);
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            [self.typeCourseArray removeAllObjects];
            [self.typeCourseArray addObjectsFromArray:[dicTemp valueForKey:@"data"]];
            [self.typeCourseTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.typeCourseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JWSearchViewTableViewCell * typeCourseCell = [tableView dequeueReusableCellWithIdentifier:@"typeCourseCell"];
    if (!typeCourseCell) {
        typeCourseCell = [[JWSearchViewTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"typeCourseCell"];
    }
    NSDictionary * dateDic = self.typeCourseArray[indexPath.row];
    typeCourseCell.searchDic = dateDic;
    return typeCourseCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JWClassficationViewController * classficationVC = [[JWClassficationViewController alloc]init];
    classficationVC.courseID = [self.typeCourseArray[indexPath.row] valueForKey:@"id"];
    [classficationVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:classficationVC animated:YES completion:^{
        
    }];
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
