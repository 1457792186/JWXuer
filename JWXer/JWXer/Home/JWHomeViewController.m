//
//  JWHomeViewController.m
//  JWXer
//
//  Created by scjy on 16/2/17.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWHomeViewController.h"

#import "AFNetworking.h"
#import "JSONKit.h"

#import "JWHomeScrollView.h"
#import "JWHomePageControl.h"

#import "JWSearchCourseViewController.h"
#import "JWHomeCollectionViewCell.h"
#import "JWCourseImageCollectionViewCell.h"
#import "JWCourseHeaderCollectionReusableView.h"
#import "JWClassficationViewController.h"
#import "JWTypeCourseViewController.h"
#import "AppDelegate.h"

#import "NSArray+Log.h"
#import "NSDictionary+Log.h"

@interface JWHomeViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong)UIImageView * logoImageView;

@property (nonatomic,strong)UIScrollView * basicScrollView;

@property (nonatomic,strong)NSMutableArray * bannerArray;
@property (nonatomic,strong)NSMutableArray * bannerURLArray;
@property (nonatomic,strong)JWHomeScrollView * bannerScrolerView;
@property (nonatomic,strong)JWHomePageControl * pageControl;
@property (nonatomic,strong)NSTimer * bannerTimer;

@property (nonatomic,strong)UICollectionView * courseImageCollectionView;
@property (nonatomic,strong)NSArray * courseImageArray;
@property (nonatomic,strong)NSArray * courseImageNameArray;
@property (nonatomic,strong)NSMutableArray * courseTypeIDArray;

@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSArray * homeCourseArray;
@property (nonatomic,assign)CGFloat collectionViewheight;
@property (nonatomic,assign)NSInteger collectionCount;

@end

@implementation JWHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.bannerTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(bannerTimerAction) userInfo:nil repeats:YES];
    
    if (self.basicScrollView) {
        [self.basicScrollView setContentOffset:CGPointMake(0.f, 0.f)];
    }
    
    if (self.pageControl && self.bannerScrolerView) {
        NSInteger currentPage = self.bannerScrolerView.currentBannerCount;
        for (NSInteger i = 0; i < currentPage; i++) {
            [self.bannerScrolerView rightShift];
        }
        self.pageControl.currentPage = self.bannerScrolerView.currentBannerCount;
    }
    
    if (self.collectionView) {
        if (self.collectionCount <= 1) {
            [self.collectionView setContentOffset:CGPointMake(0.f, 500.f)];
        }
        self.collectionCount++;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftBar.hidden = YES;
    
    self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 83.f)/2, 33.f, 83.f, 20.f)];
    self.logoImageView.image = [UIImage imageNamed:@"xuerWhite"];
    [self.myNavigationBar addSubview:self.logoImageView];
    
    UIButton * searchButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60.f - 15.f), 30.f, 60.f, 30.f)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationBar addSubview:searchButton];
    
    
    self.basicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, NavigationBarHeigh, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NavigationBarHeigh)];
    self.basicScrollView.backgroundColor = [UIColor clearColor];
    self.basicScrollView.showsVerticalScrollIndicator = NO;
    self.basicScrollView.delegate = self;
    self.basicScrollView.bounces = NO;
    
    [self.view addSubview:self.basicScrollView];
    
    //create bannerScrollerView
    [self bannerScrollerViewCreate];
    
    //create courseImageCollectionView
    [self courseImageCollectionViewCreate];
    
    //create collectionView
    [self collectionViewCreate];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.bannerTimer invalidate];
}

#pragma mark - CreateMyBanner&UIScrollViewDelegate
- (void)bannerScrollerViewCreate{
    self.bannerArray = [[NSMutableArray alloc]init];
    self.bannerURLArray = [[NSMutableArray alloc]init];
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * getBannerURL = @"http://www.xuer.com/theapi.php?act=bannerlist";
    [manger POST:getBannerURL parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
        //        NSLog(@"%@",dicTemp);
        
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            NSArray * dataArray = [dicTemp valueForKey:@"data"];
            
            for (NSDictionary * dataDic in dataArray) {
                [self.bannerArray addObject:[dataDic valueForKey:@"img"]];
                [self.bannerURLArray addObject:[dataDic valueForKey:@"url"]];
            }
            //            NSArray * imageArray = [[NSArray alloc]initWithArray:[dicTemp valueForKey:@"img"]];
            
        } else{
            [self.bannerArray addObject:@"banner"];
        }
        
        //        NSLog(@"%@",self.bannerArray);
        
        //createBannerScroller
        self.bannerScrolerView = [[JWHomeScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 150.f) withImagesArray:self.bannerArray];
        self.bannerScrolerView.delegate = self;
        [self.basicScrollView addSubview:self.bannerScrolerView];
        
        [self.bannerScrolerView.currentView addTarget:self action:@selector(bannerButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.pageControl = [[JWHomePageControl alloc]initWithFrame:CGRectMake((self.bannerScrolerView.frame.size.width - 160.f)/2, CGRectGetMaxY(self.bannerScrolerView.frame) - 30.f ,160.f, 30.f) withPageCount:[self.bannerArray count]];
        
        [self.basicScrollView addSubview:self.pageControl];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)bannerButtonAction{
    NSLog(@"banner url is %@",self.bannerURLArray[self.bannerScrolerView.currentBannerCount]);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.bannerScrolerView.contentOffset.x >= self.bannerScrolerView.frame.size.width * 2) {
        [self.bannerScrolerView rightShift];
    } else if (self.bannerScrolerView.contentOffset.x <= 0.f){
        [self.bannerScrolerView leftShift];
    }
    
    self.pageControl.currentPage = self.bannerScrolerView.currentBannerCount;
    
}

- (void)bannerTimerAction{
    [self.bannerScrolerView rightShift];
    self.pageControl.currentPage = self.bannerScrolerView.currentBannerCount;
}

#pragma mark - CreateCourseImageCollectionView
- (void)courseImageCollectionViewCreate{
    self.courseTypeIDArray = [[NSMutableArray alloc]init];
    
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
            NSArray * courseArray = [dataDicTemp valueForKey:@"data"];
            for (NSDictionary * dataDic in courseArray) {
                [self.courseTypeIDArray addObject:[dataDic valueForKey:@"arrchildid"]];
            }
            [self.courseImageCollectionView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    UICollectionViewFlowLayout * imageCollectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    imageCollectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.courseImageArray = @[@"yun2",@"wangluoyingxiao2",@"qianduan2",@"houtai",@"youxi2",@"shuju2",@"jisuanjiyuyan2",@"gengduo"];
    self.courseImageNameArray = @[@"云系统管理",@"网络营销",@"前端开发",@"后台开发",@"游戏开发",@"数据库",@"计算机语言",@"更多"];
    
    self.courseImageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.f, 150.f, [UIScreen mainScreen].bounds.size.width, 180.f) collectionViewLayout:imageCollectionViewLayout];
    self.courseImageCollectionView.backgroundColor = [UIColor clearColor];
    self.courseImageCollectionView.tag = 233333;
    self.courseImageCollectionView.delegate = self;
    self.courseImageCollectionView.dataSource = self;
    
    [self.courseImageCollectionView registerClass:[JWCourseImageCollectionViewCell class] forCellWithReuseIdentifier:@"CourseImageCell"];
    
    [self.basicScrollView addSubview:self.courseImageCollectionView];
}



#pragma mark - CreateCollectionView
- (void)collectionViewCreate{
    self.homeCourseArray = [[NSArray alloc]init];
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * homeCourseListURL = @"http://www.xuer.com/theapi.php?act=indexlist";
    
    [manger POST:homeCourseListURL parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
        //        NSLog(@"%@",dicTemp);
        
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        
        if (status == 200) {
            self.homeCourseArray = [dicTemp valueForKey:@"data"];
//            NSLog(@"%@",self.homeCourseArray);
            
            [self.collectionView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //create collectionView
    UICollectionViewFlowLayout * collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.courseImageCollectionView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:collectionViewLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.tag = 20086;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.basicScrollView addSubview:self.collectionView];
    
    
    //add Header
    [self.collectionView registerClass:[JWCourseHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"jwCollectionHeader"];
    
    [self.collectionView registerClass:[JWHomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCollectionViewCell"];
    
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 233333) {
        if (indexPath.row == 7) {
            self.getSelectedCount(@"1");
            return;
        }
        
        JWTypeCourseViewController * typeCourseViewController = [[JWTypeCourseViewController alloc]init];
        typeCourseViewController.courseID = self.courseTypeIDArray[indexPath.row];
        [typeCourseViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:typeCourseViewController animated:YES completion:^{
            
        }];
    }
    
    if (collectionView.tag == 20086) {
        JWClassficationViewController * classficationVC = [[JWClassficationViewController alloc]init];
        classficationVC.hidesBottomBarWhenPushed = YES;
        NSArray * courseArray = [self.homeCourseArray[indexPath.section] valueForKey:@"course"];
        NSDictionary * courseDic = courseArray[indexPath.row];
        classficationVC.courseID = [courseDic valueForKey:@"id"];
        [classficationVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:classficationVC animated:YES completion:^{
            
        }];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 233333) {
        return CGSizeMake(80.f, 80.f);
    }
    
    return CGSizeMake(150.f, 100.f);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5.f, 8.f, 5.f, 8.f);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (collectionView.tag == 20086) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30.f);
    }
    return CGSizeMake(0.f, 0.f);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView.tag == 233333) {
        return 1;
    }
    
    return [self.homeCourseArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 233333) {
        return self.courseImageArray.count;
    }
    
    return [[self.homeCourseArray[section] valueForKey:@"course"] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 233333) {
        JWCourseImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseImageCell" forIndexPath:indexPath];
        cell.courseName = self.courseImageNameArray[indexPath.row];
        cell.imageName = self.courseImageArray[indexPath.row];
        return cell;
    }
    
    JWHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCollectionViewCell" forIndexPath:indexPath];
    
    NSArray * courseArray = [self.homeCourseArray[indexPath.section] valueForKey:@"course"];
    NSDictionary * courseDic = courseArray[indexPath.row];
    cell.courseName = [courseDic valueForKey:@"stitle"];
    cell.imageName = [courseDic valueForKey:@"thumb"];
    
    
    if (self.collectionViewheight < cell.frame.origin.y + cell.frame.size.height + 5.f) {
        self.collectionViewheight = cell.frame.origin.y + cell.frame.size.height + 5.f;
        UITabBarController * tabBarVCTemp = [[UITabBarController alloc]init];
        self.basicScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.bannerScrolerView.frame.size.height + self.courseImageCollectionView.frame.size.height + self.collectionViewheight + tabBarVCTemp.tabBar.frame.size.height);
        self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, self.collectionViewheight);
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (collectionView.tag == 20086) {
            JWCourseHeaderCollectionReusableView * jwHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"jwCollectionHeader" forIndexPath:indexPath];
            
            NSDictionary * typeDic = self.homeCourseArray[indexPath.section];
            jwHeaderView.typeTittle = [typeDic valueForKey:@"title"];
            
            return jwHeaderView;
        }
    }
    return nil;
}

#pragma mark - ButtonAction
- (void)searchButtonAction{
    JWSearchCourseViewController * serachViewController = [[JWSearchCourseViewController alloc]init];
    serachViewController.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    [self presentViewController:serachViewController animated:NO completion:^{
        
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
