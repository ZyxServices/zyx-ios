//
//  XZLogRegisterViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZLogRegisterViewController.h"
#import "XZRegisterUserViewController.h"
#import "XZNavigationController.h"
#import "XZForgetPasswordViewController.h"
#import "MBProgressHUD+MJ.h"
@interface XZLogRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation XZLogRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"体育家账户登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(closed)image:@"navigationButtonReturn"highImage:@"navigationButtonReturnClick"];
    
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
 *  状态栏的颜色
 *
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)closed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [params setObject:self.phoneField.text forKey:@"phone"];
    [params setObject:self.passwordField.text forKey:@"pwd"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/login"];

    [XZNetManager post:url params:params success:^(id json) {
        [MBProgressHUD showSuccess:@"登录成功"];
        NSString *token = [[json objectForKey:@"data"] objectForKey:@"token"];
        [Helper_UserDefault setObject:token forKey:@"TOKEN"];
        
        XZLog(@"%@",json);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.localizedDescription];
//        XZLog(@"%@",error);
    }];
}

- (IBAction)registerUser:(id)sender {
    XZRegisterUserViewController *vc = [[XZRegisterUserViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetPassword:(id)sender {
    
    [self.navigationController pushViewController:[XZForgetPasswordViewController new] animated:YES];
}
@end
