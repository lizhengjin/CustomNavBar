//
//  NextViewController.m
//  CusNavBarDemo
//
//  Created by liqi on 2019/5/29.
//  Copyright © 2019年 zhht. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+CusNavBar.h"
@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
    [self cus_setTitle:@"首页"];
    [self cus_leftBack];
    //   [self cus_leftBackWithAction:@selector(back)];
    [self cus_rightButtonWithTitle:@"自定义右键" action:@selector(chargeRecord)];
}
- (void)back
{
    NSLog(@"back to ...");
}
- (void)chargeRecord
{
    NSLog(@"chargeRecord");
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
