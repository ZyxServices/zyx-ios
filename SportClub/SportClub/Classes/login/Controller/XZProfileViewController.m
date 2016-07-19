//
//  XZProfileViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZProfileViewController.h"
#import "NSString+MD5.h"
#import "AFNetworking.h"
#import "XZTextField.h"
@interface XZProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *userPhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet XZTextField *nicknameField;
@property (weak, nonatomic) IBOutlet XZTextField *passwordField;

@end

@implementation XZProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料完善";
}

#pragma mark -Button Method
/**
 *  上传用户头像
 *
 */
- (IBAction)userPhotoBtnClick:(id)sender {
}

/**
 *  是否显示密码
 *
 */
- (IBAction)isShowPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"choice_down"] forState:UIControlStateSelected];
        _passwordField.secureTextEntry = NO;
    } else {
        [sender setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        _passwordField.secureTextEntry = YES;
    }
}

/**
 *  完成注册
 *
 */
- (IBAction)completedRegister:(id)sender {
    
    NSString *urlSring = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/register"];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:_phone forKey:@"phone"];
    [params setObject:[_passwordField.text MD5] forKey:@"pwd"];
    [params setObject:_nicknameField.text forKey:@"nickname"];
    
//    UIImage *img = [UIImage imageNamed:@"set_user_photo"];
//    NSData *imaDaga = UIImagePNGRepresentation(img);
    
  
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:urlSring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:imaDaga name:@"avatar" fileName:@"set_user_photo" mimeType:@"image/png"];

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XZLog(@"%@",responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XZLog(@"注册接口%@",error);

    }];
    

}

@end
