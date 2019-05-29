//
//  UIViewController+CusNavBar.m
//  SJZ
//
//  Created by liqi on 2019/5/24.
//  Copyright © 2019年 智慧停车. All rights reserved.
//

#import "UIViewController+CusNavBar.h"
#import "UIView+LayoutMethods.h"


#define NavBar_RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define NavBar_LineColor        NavBar_RGBAColor(220,220,220,1) //底部线颜色

#define NavBar_BackImageName    @"back"  //返回 imageName
#define SCREEN_WIDTH              ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT             ([[UIScreen mainScreen] bounds].size.height)
#define NavBar_StatusBar_Height   [UIApplication sharedApplication].statusBarFrame.size.height
#define NavBar_Height              (NavBar_StatusBar_Height + 44.0)  //状态栏高度+导航栏
#define NavBar_IPhoneX_Top_SafeH  24.0//iphonex 顶部安全距离
#define NavBarButtonLeft_Width  60  //item left button宽度
#define NavBarButtonRight_Width 60  //item right button 宽度
#define NavBarButtonRightTitle_Width 100  //item right button 宽度
#define NavBarButton_Height     44  //item button 高度
#define NavBarButton_TitleFont  16  //item Button字体大小
#define NavbarItem_Space        10 //item 到屏幕左右间距(除系统navigationBar 返回item外)
#define NavBarButton_ImgSpace   8 //item button 图片边缘到button左右两端间隙
static BOOL const translucent = YES;//导航栏以下视图是否自动向下偏移64,YES不偏移,NO偏移
typedef NS_ENUM(NSInteger, NavBarItemType)
{
  NavBarItemTypeLeftImage,
  NavBarItemTypeRightTitle,
  NavBarItemTypeRightImage
};

@implementation UIViewController (CusNavBar)

- (UILabel *)cus_setTitle:(NSString *)titile
{
    [self cus_initNavBar];
    return  [self cus_setNavBarTitle:titile];
}
- (void)cus_leftBack
{
    [self cus_leftBackWithAction:@selector(backAction)];
}
- (void)cus_leftBackWithAction:(SEL)selector
{
  [self setPopRecognizerEnable:[NSStringFromSelector(selector) isEqualToString:@"backAction"]];
  [self cus_leftButtonWithImageName:NavBar_BackImageName action:selector];
}
- (UIButton *)cus_rightButtonWithTitle:(NSString *)title action:(SEL)selector
{
  return  [self cus_setNavBarButtonWithName:title action:selector type:NavBarItemTypeRightTitle];
}
- (UIButton *)cus_rightButtonWithImage:(NSString *)image action:(SEL)selector
{
    return [self cus_setNavBarButtonWithName:image action:selector type:NavBarItemTypeRightImage];
}

#pragma mark - private
- (void)cus_initNavBar
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = translucent;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBar_Height)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, NavBar_Height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineLabel.backgroundColor = NavBar_LineColor;
    [bgView addSubview:lineLabel];
    
    [self.view addSubview:bgView];
}

- (UILabel *)cus_setNavBarTitle:(NSString *)title
{
    UILabel *titleLabel = [self createNavBarTitleWithName:title];
    [self.view addSubview:titleLabel];
    return titleLabel;
}
- (UIButton *)cus_leftButtonWithImageName:(NSString *)name action:(SEL)selector
{
  return  [self cus_setNavBarButtonWithName:name action:selector type:NavBarItemTypeLeftImage];
}
- (UIButton *)cus_setNavBarButtonWithName:(NSString *)name action:(SEL)selector type:(NavBarItemType)type
{
    if (type == NavBarItemTypeLeftImage) {
        UIButton *button = [self createNavBarButtonWithFrame:CGRectMake(NavbarItem_Space, NavBar_StatusBar_Height, NavBarButtonLeft_Width, NavBarButton_Height) action:selector];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -NavBarButtonLeft_Width/2.0+NavBarButton_ImgSpace, 0, 0);
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [self.view addSubview:button];
        return button;
    }
    else if (type == NavBarItemTypeRightTitle){
        UIButton *button = [self createNavBarButtonWithFrame:CGRectMake(SCREEN_WIDTH - NavBarButtonRightTitle_Width, NavBar_StatusBar_Height, NavBarButtonRightTitle_Width, NavBarButton_Height) action:selector];
        button.titleLabel.font = [UIFont systemFontOfSize:NavBarButton_TitleFont];
      //  [button.titleLabel sizeToFit];
     //   [button setX:SCREEN_WIDTH - NavbarItem_Space - button.titleLabel.width];
        [button setTitle:name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        return button;
    }
    else if (type == NavBarItemTypeRightImage){
        UIButton *button = [self createNavBarButtonWithFrame:CGRectMake(SCREEN_WIDTH - NavBarButtonRight_Width - NavbarItem_Space, NavBar_StatusBar_Height, NavBarButtonRight_Width, NavBarButton_Height) action:selector];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -NavBarButtonRight_Width/2.0+NavBarButton_ImgSpace);
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [self.view addSubview:button];
        return button;
    }
    return nil;
}

- (UILabel *)createNavBarTitleWithName:(NSString *)titleName
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = titleName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:NavBarButton_TitleFont];
    [titleLabel sizeToFit];
    if (titleLabel.width > 150) {
        titleLabel.frame = CGRectMake(0, 0, 150, titleLabel.height);
    }
    [titleLabel setY: NavBar_StatusBar_Height+(NavBar_Height-  NavBar_StatusBar_Height)/2 - titleLabel.height/2];
    [titleLabel setCenterX:SCREEN_WIDTH/2];
    return titleLabel;
}

- (UIButton *)createNavBarButtonWithFrame:(CGRect)frame action:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setPopRecognizerEnable:(BOOL)enable
{
    self.navigationController.interactivePopGestureRecognizer.enabled = enable;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        for (UIGestureRecognizer *popGesture in self.navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = enable;
        }
    }
}

- (void)backAction
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
        if ([viewControllers objectAtIndex:viewControllers.count -1] == self) {
             [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}
@end
