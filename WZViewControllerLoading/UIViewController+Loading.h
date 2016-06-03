//
//  UIViewController+Loading.h
//  launcher
//
//  Created by williamzhang on 15/11/24.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  loading VC 工具类

#import <UIKit/UIKit.h>

@interface UIViewController (Loading)

@property (nonatomic, readonly) BOOL wz_loading;
/// default is YES
@property (nonatomic ,assign) BOOL wz_loadingInteractionEnabled;

#pragma mark - Success
- (void)wz_postSuccess;
- (void)wz_postSuccess:(NSString *)message;
- (void)wz_postSuccess:(NSString *)message overTime:(NSTimeInterval)second;

#pragma mark - Error
- (void)wz_postError:(NSString *)message;
- (void)wz_postError:(NSString *)message duration:(CGFloat)duration;
- (void)wz_postError:(NSString *)message detailMessage:(NSString *)detailMessage duration:(CGFloat)duration;

#pragma mark - Loading
- (void)wz_postProgress:(float)progress;
- (void)wz_postLoading;
- (void)wz_postLoading:(NSString *)message;
- (void)wz_postLoading:(NSString *)title message:(NSString *)message;
- (void)wz_postLoading:(NSString *)title message:(NSString *)message overTime:(NSTimeInterval)second;

#pragma mark - Hide
- (void)wz_hideLoading;

@end
