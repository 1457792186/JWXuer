
//
//  JWCourseViewController.m
//  JWXer
//
//  Created by scjy on 16/2/17.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWCourseViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#import "NSArray+Log.h"
#import "NSDictionary+Log.h"

#import "JWCourseCollectionViewCell.h"
#import "JWSearchButton.h"
#import "JWSearchCourseViewController.h"
#import "JWTypeCourseViewController.h"

@interface JWCourseViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)JWSearchButton * searchButton;

@property (nonatomic,strong)NSArray * courseArray;
@property (nonatomic,strong)UICollectionView * courseView;

@end

@implementation JWCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftBar.hidden = YES;
    
    UIImageView * logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(15.f, 30.f, 80.f, 25.f)];
    logoImage.image  = [UIImage imageNamed:@"xuerWhite"];
    logoImage.tintColor = [UIColor whiteColor];
    [self.myNavigationBar addSubview:logoImage];
    
    self.searchButton = [[JWSearchButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 15.f - 210.f), 30.f, 210.f, 30.f)];
    [self.myNavigationBar addSubview:self.searchButton];
    UIButton * skipButton = [[UIButton alloc]initWithFrame:self.searchButton.frame];
    [skipButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:skipButton];
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    NSString * courseURL = @"http://www.xuer.com/theapi.php?act=typelist";
    
    [manger POST:courseURL parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        JSONDecoder * courseJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dataDicTemp = [courseJsonDecoder objectWithData:responseObject];
//        NSLog(@"%@",dataDicTemp);
        
        NSInteger status = [[dataDicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            self.courseArray = [dataDicTemp valueForKey:@"data"];
            
            [self.courseView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    UICollectionViewFlowLayout * courseCollectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    courseCollectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UITabBarController * tabTemp = [[UITabBarController alloc]init];
    
    self.courseView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.f, NavigationBarHeigh, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NavigationBarHeigh - tabTemp.tabBar.bounds.size.height) collectionViewLayout:courseCollectionViewLayout];
    self.courseView.backgroundColor = [UIColor clearColor];
    self.courseView.showsVerticalScrollIndicator = NO;
    self.courseView.dataSource = self;
    self.courseView.delegate = self;
    
    [self.view addSubview:self.courseView];
    
    [self.courseView registerClass:[JWCourseCollectionViewCell class] forCellWithReuseIdentifier:@"courseViewCell"];
}

#pragma mark - SearchButtonAction
- (void)searchButtonAction:(JWSearchButton *)searchButton{
    JWSearchCourseViewController * searchVC = [[JWSearchCourseViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [searchVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:searchVC animated:YES completion:^{
        
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.courseArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JWCourseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"courseViewCell" forIndexPath:indexPath];
    
    NSDictionary * dataDic = self.courseArray[indexPath.row];
//    NSLog(@"%@",dataDic);
    cell.courseName = [dataDic valueForKey:@"name"];
    cell.courseImage = [dataDic valueForKey:@"img"];
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JWTypeCourseViewController * typeCourseViewController = [[JWTypeCourseViewController alloc]init];
    NSDictionary * dataDic = self.courseArray[indexPath.row];
    typeCourseViewController.courseID = [dataDic valueForKey:@"arrchildid"];
    [typeCourseViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:typeCourseViewController animated:YES completion:^{
        
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 10.f * 2 - 1.f * 4) / 3, ([UIScreen mainScreen].bounds.size.width - 10.f * 2) / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f;
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
