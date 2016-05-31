
//
//  JWClassficationViewController.m
//  JWXer
//
//  Created by scjy on 16/2/27.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWClassficationViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "UIColor+HexColor.h"
#import "UIImageView+WebCache.h"

#import "JWNavigationBarButton.h"
#import "JWShareView.h"
#import "JWUserInfo.h"
#import "JWIndexTableViewCell.h"
#import "JWCommentTableViewCell.h"
#import "JWCommentView.h"

@interface JWClassficationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)JWNavigationBarButton * backButton;
@property (nonatomic,strong)JWNavigationBarButton * shareButton;

@property (nonatomic,strong)UIImageView * bannerImageView;
@property (nonatomic,strong)NSDictionary * dataDic;

@property (nonatomic,strong)UIView * courseShowView;
@property (nonatomic,strong)UILabel * courseNameLabel;
@property (nonatomic,strong)UILabel * commenterLabel;
@property (nonatomic,strong)UILabel * listorderLabel;
@property (nonatomic,strong)UILabel * goStudyLabel;

@property (nonatomic,strong)JWUserInfo * userInfo;
@property (nonatomic,strong)UIView * detailView;
@property (nonatomic,assign)CGRect detailViewFrame;
@property (nonatomic,assign)NSInteger firstViewCount;

@property (nonatomic,strong)UITableView * indexTableView;
@property (nonatomic,strong)NSArray * indexArray;
@property (nonatomic,strong)UITableView * commentTableView;
@property (nonatomic,strong)NSArray * commentArray;

@property (nonatomic,strong)JWCommentView * commentView;

@end

@implementation JWClassficationViewController

- (void)loadView{
    [super loadView];
    
    self.bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 150.f)];
    [self.view addSubview:self.bannerImageView];
    self.userInfo = [JWUserInfo shareUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.backButton = [[JWNavigationBarButton alloc]init];
    self.backButton.imageName = @"Arrow";
    self.backButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    [self.backButton addTarget:self action:@selector(touchBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.shareButton = [[JWNavigationBarButton alloc]init];
    self.shareButton.imageName = @"fenxiang";
    self.shareButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    self.shareButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 15.f - 25.f), 30.f, 25.f, 30.f);
    [self.shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareButton];
    
    [self getCourseInfoWithCourseID:self.courseID];
    [self courseShowViewSet];
    [self goStudyButtonSet];
    
}


- (void)getCourseInfoWithCourseID:(NSString *)courseID{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * courseInfoURL = @"http://www.xuer.com/theapi.php?act=courseinfo";
    NSDictionary * postDic = @{@"id":courseID,@"taguid":self.userInfo.userID};
    
    [manger POST:courseInfoURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
//        NSLog(@"%@",dicTemp);
        
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        
        if (status == 200) {
            self.dataDic = [dicTemp valueForKey:@"data"];
            
            NSInteger isjoin = [[self.dataDic valueForKey:@"isjoin"] integerValue];
            if (isjoin == 0) {
                self.goStudyLabel.text = @"我要学习";
            } else{
                self.goStudyLabel.text = @"退出课程";
            }
            
            [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic valueForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"logo"]];
//            NSLog(@"%@",[self.dataDic valueForKey:@"thumb"]);
            
            self.indexArray = [self.dataDic valueForKey:@"children"];
            
            self.commentArray = [self.dataDic valueForKey:@"comment"];
            
            if (self.firstViewCount == 0) {
                self.courseNameLabel.text = [self.dataDic valueForKey:@"stitle"];
                
                self.commenterLabel.text = [NSString stringWithFormat:@"(%@)",[self.dataDic valueForKey:@"comment_count"]];
                
                self.listorderLabel.text = [NSString stringWithFormat:@"%ld人在学",[[self.dataDic valueForKey:@"listorder"] integerValue]];
                
                UIImage * imageStar = [UIImage imageNamed:@"xin-hui"];
                
                UIImage * imageRedStar = [UIImage imageNamed:@"hongxin"];
                NSInteger starCount = [[self.dataDic valueForKey:@"star"] integerValue] / 2;
                for (int i = 0; i < 5; i++) {
                    UIImageView * imageViewTemp = [[UIImageView alloc]initWithFrame:CGRectMake(10.f + i * (2.f + 12.f), CGRectGetMaxY(self.courseNameLabel.frame) + 10.f, 12.f, 12.f)];
                    if (i <= starCount - 1) {
                        imageViewTemp.image = imageRedStar;
                    } else{
                        imageViewTemp.image = imageStar;
                    }
                    [self.courseShowView addSubview:imageViewTemp];
                }
                [self addFirstDetailView];
                self.firstViewCount = 1;
            } else{
                [self.indexTableView reloadData];
                [self.commentTableView reloadData];
            }
            
        } else{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark- SetSubViews

- (void)courseShowViewSet{
    self.courseShowView = [[UIView alloc]initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.bannerImageView.frame), [UIScreen mainScreen].bounds.size.width, 70.f)];
    self.courseShowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.courseShowView];
    
    self.courseNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 5.f, [UIScreen mainScreen].bounds.size.width - 10.f * 2, 30.f)];
    self.courseNameLabel.font = [UIFont systemFontOfSize:20.f];
    [self.courseShowView addSubview:self.courseNameLabel];
    
    self.commenterLabel= [[UILabel alloc]initWithFrame:CGRectMake(95.f, CGRectGetMaxY(self.courseNameLabel.frame) + 10.f, 120.f, 12.f)];
    self.commenterLabel.font = [UIFont systemFontOfSize:10.f];
    
    self.commenterLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
    [self.courseShowView addSubview:self.commenterLabel];
    
    self.listorderLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.commenterLabel.frame) + 5.f, self.commenterLabel.frame.origin.y, 120.f, 12.f)];
    self.listorderLabel.font = [UIFont systemFontOfSize:10.f];
    [self.courseShowView addSubview:self.listorderLabel];
    
    
    UISegmentedControl * courseSegementControl = [[UISegmentedControl alloc]initWithItems:@[@"简介",@"目录",@"评价"]];
    courseSegementControl.frame = CGRectMake(0.f, CGRectGetMaxY(self.courseShowView.frame) + 2.f, [UIScreen mainScreen].bounds.size.width, 40.f);
    courseSegementControl.tintColor = [UIColor colorWithHexString:@"#f6f6f6"];
    //自定义SegementControl
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.f],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#419f94"]};
    [courseSegementControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.f],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#46948a"]};
    [courseSegementControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [courseSegementControl addTarget:self action:@selector(segementControlChoose:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:courseSegementControl];
    
    self.detailViewFrame = CGRectMake(0.f, CGRectGetMaxY(courseSegementControl.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(courseSegementControl.frame) - 70.f);
    
}

- (void)addFirstDetailView{
    self.detailView = [[UIView alloc]initWithFrame:self.detailViewFrame];
//    NSLog(@"%@",self.dataDic);
    NSDictionary * teacherDic = [self.dataDic valueForKey:@"teacherlist"][0];
    UIImageView * teacherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, 10.f, 50.f, 50.f)];
    [teacherImageView sd_setImageWithURL:[NSURL URLWithString:[teacherDic valueForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    [self.detailView addSubview:teacherImageView];
    
    UILabel * teacherNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(teacherImageView.frame) + 10.f, teacherImageView.frame.origin.y, 120.f, 15.f)];
    teacherNameLabel.font = [UIFont systemFontOfSize:13.f];
    teacherNameLabel.text = [teacherDic valueForKey:@"realname"];
    [self.detailView addSubview:teacherNameLabel];
    
    UITextView * teacherIntroduceTextView = [[UITextView alloc]initWithFrame:CGRectMake(teacherNameLabel.frame.origin.x, CGRectGetMaxY(teacherNameLabel.frame) + 10.f, [UIScreen mainScreen].bounds.size.width - teacherNameLabel.frame.origin.x - 10.f, self.detailView.frame.size.height - (CGRectGetMaxY(teacherNameLabel.frame) + 10.f))];
    teacherIntroduceTextView.text = [teacherDic valueForKey:@"teach_introduce"];
    teacherIntroduceTextView.editable = NO;
    [self.detailView addSubview:teacherIntroduceTextView];
    
    [self.view addSubview:self.detailView];
}

- (void)segementControlChoose:(UISegmentedControl *)segmentedControl{
    if (self.detailView) {
        [self.detailView removeFromSuperview];
        self.detailView = nil;
    }
    if (segmentedControl.selectedSegmentIndex == 0) {
        [self addFirstDetailView];
        return;
    }
    
    self.detailView = [[UIView alloc]initWithFrame:self.detailViewFrame];
    [self.view addSubview:self.detailView];
    
    if (segmentedControl.selectedSegmentIndex == 1) {
        self.indexTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.detailView.frame.size.width, self.detailView.frame.size.height) style:UITableViewStylePlain];
        self.indexTableView.delegate = self;
        self.indexTableView.dataSource = self;
        [self.detailView addSubview:self.indexTableView];
        self.indexTableView.tag = 9001;
        return;
    }
    
    self.commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.detailView.frame.size.width, self.detailView.frame.size.height) style:UITableViewStylePlain];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    [self.detailView addSubview:self.commentTableView];
    self.commentTableView.tag = 9002;
}

- (void)goStudyButtonSet{
    UIButton * goStudyButton = [[UIButton alloc]initWithFrame:CGRectMake(8.f, [UIScreen mainScreen].bounds.size.height - 60.f, [UIScreen mainScreen].bounds.size.width - 8.f * 2, 45.f)];
    goStudyButton.backgroundColor = [UIColor colorWithHexString:@"#46948a"];
    goStudyButton.layer.cornerRadius = 20.f;
    
    self.goStudyLabel = [[UILabel alloc]initWithFrame:CGRectMake((goStudyButton.frame.size.width - 60.f) / 2, (goStudyButton.frame.size.height - 15.f) / 2, 60.f, 15.f)];
    self.goStudyLabel.textAlignment = NSTextAlignmentCenter;
    self.goStudyLabel.textColor = [UIColor colorWithHexString:@"#46948a"];
    self.goStudyLabel.font = [UIFont systemFontOfSize:15.f];
    self.goStudyLabel.text = @"我要学习";
    self.goStudyLabel.textColor = [UIColor whiteColor];
    [goStudyButton addSubview:self.goStudyLabel];
    [goStudyButton addTarget:self action:@selector(goStudyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goStudyButton];
}

#pragma mark - ButtonAction

- (void)touchBackAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)shareButtonAction{
    JWShareView * shareVC = [[JWShareView alloc]init];
    [self.view addSubview:shareVC];
}

- (void)goStudyButtonAction{
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        if ([self.goStudyLabel.text isEqualToString:@"我要学习"]) {
            self.goStudyLabel.text = @"退出课程";
        } else{
            self.goStudyLabel.text = @"我要学习";
        }
        
    }];
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * typeCourseURL = @"http://www.xuer.com/theapi.php?act=joincourse";
    
    NSDictionary * postDic = [[NSDictionary alloc]init];
    if ([self.goStudyLabel.text isEqualToString:@"我要学习"]) {
        postDic = @{@"uid":self.userInfo.userID,@"courseid":self.courseID,@"isjoin":@"1"};
    } else{
        postDic = @{@"uid":self.userInfo.userID,@"courseid":self.courseID,@"isjoin":@"0"};
    }
    
    [manger POST:typeCourseURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
        //        NSLog(@"%@",dicTemp);
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"操作成功" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        } else if (status == 1){
            
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户或课程id为空" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)commentButtonAction{
    self.commentView = [[JWCommentView alloc]init];
    self.commentView.courseID = self.courseID;
    self.commentView.userID = self.userInfo.userID;
    self.commentView.commentView.returnKeyType = UIReturnKeySend;
    self.commentView.commentView.delegate = self;
    [self.commentView.sendButton addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commentView];
}

- (void)sendComment{
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * courseInfoURL = @"http://www.xuer.com/theapi.php?act=coursecommentadd";
    NSDictionary * postDic = @{@"uid":self.commentView.userID,@"cid":self.commentView.courseID,@"content":self.commentView.commentView.text,@"star":[NSString stringWithFormat:@"%ld",(long)self.commentView.starView.starCount]};
    
    [manger POST:courseInfoURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder * myJsonDecoder = [JSONDecoder decoder];
        NSDictionary * dicTemp = [myJsonDecoder objectWithData:responseObject];
        NSInteger status = [[dicTemp valueForKey:@"status"] integerValue];
        if (status == 200) {
            UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                [self.commentView removeFromSuperview];
            }];
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"评论成功" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        } else if (status == 1){
            UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
            }];
            UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户或课程id为空" preferredStyle:UIAlertControllerStyleAlert];
            [myAlert addAction:selectAction];
            [self presentViewController:myAlert animated:YES completion:^{
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 9001) {
        NSLog(@"点了cell");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 9001) {
        return 40.f;
    }
    return 70.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 9002 && section == 0) {
        return 70.f;
    }
    return 0.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 9002 && section == 0) {
        UIButton * commentButton = [[UIButton alloc]initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 70.f)];
        [commentButton addTarget:self action:@selector(commentButtonAction) forControlEvents:UIControlEventTouchUpInside];
        UILabel * commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, commentButton.frame.size.width, 40.f)];
        commentLabel.textAlignment = NSTextAlignmentCenter;
        commentLabel.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
        commentLabel.text = @"评价该课程";
        [commentButton addSubview:commentLabel];
        for (int i = 0; i < 5; i++) {
            UIImageView * imageViewTemp = [[UIImageView alloc]initWithFrame:CGRectMake(commentButton.frame.size.width / 2 - (20.f * 2.5 + 10.f * 2) + i * (10.f + 20.f), CGRectGetMaxY(commentLabel.frame), 20.f, 20.f)];
            imageViewTemp.image = [UIImage imageNamed:@"xin-da"];
            [commentButton addSubview:imageViewTemp];
        }
        
        return commentButton;
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 9002) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 9001) {
        return self.indexArray.count;
    }
    if (tableView.tag == 9002 && section == 0) {
        return 0;
    }
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 9001) {
        JWIndexTableViewCell * indexCell = [tableView dequeueReusableCellWithIdentifier:@"indexCell"];
        if (!indexCell) {
            indexCell = [[JWIndexTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"indexCell"];
        }
        indexCell.dataDic = self.indexArray[indexPath.row];
        return indexCell;
    }
    
    JWCommentTableViewCell * commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    if (!commentCell) {
        commentCell = [[JWCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"commentCell"];
    }
    commentCell.dataDic = self.commentArray[indexPath.row];
    return commentCell;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendComment];
    }
    
    return YES;
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
