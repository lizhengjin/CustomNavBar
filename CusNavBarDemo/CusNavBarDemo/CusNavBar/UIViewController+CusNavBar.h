//
//  UIViewController+CusNavBar.h
//  SJZ
//
//  Created by liqi on 2019/5/24.
//  Copyright © 2019年 智慧停车. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CusNavBar)<UIGestureRecognizerDelegate>

// 自定义navigationBar  包括push  pop 
- (UILabel *)cus_setTitle:(NSString *)titile;
- (void)cus_leftBack;
- (void)cus_leftBackWithAction:(SEL)selector;
- (UIButton *)cus_rightButtonWithTitle:(NSString *)title action:(SEL)selector;
- (UIButton *)cus_rightButtonWithImage:(NSString *)image action:(SEL)selector;
@end

NS_ASSUME_NONNULL_END
