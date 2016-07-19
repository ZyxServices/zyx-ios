//
//  XZNewPasswordViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZNewPasswordViewController.h"

@interface XZNewPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *repasswordField;
@end

@implementation XZNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新密码";
}

- (IBAction)newPasswordSucceed:(id)sender {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:_phone forKey:@"phone"];
    [params setObject:self.passwordField.text forKey:@"pwd"];
    [params setObject:self.repasswordField.text forKey:@"re_pwd"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/retrievepwd"];

    [XZNetManager post:url params:params success:^(id json) {
        [MBProgressHUD showSuccess:@"重置密码成功,请重新登录"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.localizedDescription];
    }];
}
@end
