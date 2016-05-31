//
//  ChangeIconViewController.m
//  登陆界面
//
//  Created by scjy on 16/1/16.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "ChangeIconViewController.h"
#import "JWUserInfo.h"

@interface ChangeIconViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIButton * localPhotoButton;
@property (nonatomic,strong)UIImage * selectImage;
@property (nonatomic,copy)NSString * filePath;//图片2进制路径

@end

@implementation ChangeIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tittleLabel = [[JWNavigationBarLabel alloc]init];
    self.tittleLabel.text = @"修改头像";
    [self.myNavigationBar addSubview:self.tittleLabel];
    
    CGFloat buttonWidth = ([UIScreen mainScreen].bounds.size.width - 30.f)/3;
    UIButton * photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0.f, 64.f, buttonWidth, buttonWidth)];
    UIImageView * imgTemp = [[UIImageView alloc]initWithFrame:CGRectMake(5.f, 5.f, photoButton.frame.size.width - 5.f * 2, photoButton.frame.size.height - 5.f * 2)];
    imgTemp.image = [UIImage imageNamed:@"camera"];
    [photoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [photoButton addSubview:imgTemp];
    [self.view addSubview:photoButton];
    
    self.localPhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(photoButton.frame) + 10.f, 64.f, buttonWidth, buttonWidth)];
//    [localPhotoButton setTitle:@"打开本地相册" forState:UIControlStateNormal];
    [self.localPhotoButton setImage:[UIImage imageNamed:@"updateIcon"] forState:UIControlStateNormal];
    self.localPhotoButton.imageView.frame = CGRectMake(0.f, 0.f, buttonWidth, buttonWidth);
    [self.localPhotoButton addTarget:self action:@selector(LocalPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.localPhotoButton];
    
}


#pragma mark-take Photo
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    NSLog(@"%@",info);
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        JWUserInfo * userInfo = [JWUserInfo shareUserInfo];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为userID + Icon_200_200.jpg
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@Icon_200_200.jpg",userInfo.userID]] contents:data attributes:nil];
        //保存&得到路径需要一致
        //得到选择后沙盒中图片的完整路径
        self.filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  [NSString stringWithFormat:@"/%@Icon_200_200.jpg",userInfo.userID]];
        
        self.selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if (self.selectImage) {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.localPhotoButton.frame.size.width, self.localPhotoButton.frame.size.height)];
            imageView.image = self.selectImage;
            
            [self.localPhotoButton addSubview:imageView];
        }
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        return;
    }
    
    
    NSLog(@"%@",info);
    self.filePath = [info objectForKey:UIImagePickerControllerReferenceURL];
    self.selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (self.selectImage) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.localPhotoButton.frame.size.width, self.localPhotoButton.frame.size.height)];
        imageView.image = self.selectImage;
        
        [self.localPhotoButton addSubview:imageView];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeInfoSave{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getInfoWithInfo:withTag:)]) {
        [self.delegate getInfoWithInfo:_filePath withTag:1002];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
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
