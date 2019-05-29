//
//  CustomViewController.m
//  CusNavBarDemo
//
//  Created by liqi on 2019/5/29.
//  Copyright © 2019年 zhht. All rights reserved.
//

#import "CustomViewController.h"
#import "NextViewController.h"
@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:button];
}
- (void)buttonClick
{
    NextViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
//    [self.navigationController presentViewController:next animated:YES completion:nil];
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
