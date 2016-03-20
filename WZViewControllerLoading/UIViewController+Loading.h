//
//  UIViewController+Loading.h
//  launcher
//
//  Created by williamzhang on 15/11/24.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  loading VC 工具类

#import <UIKit/UIKit.h>

@interface UIViewController (Loading)

@property (nonatomic, readonly, getter=isLoading) BOOL loading;

#pragma mark - Success
- (void)postSuccess;
- (void)postSuccess:(NSString *)message;
- (void)postSuccess:(NSString *)message overTime:(NSTimeInterval)second;

#pragma mark - Error
- (void)postError:(NSString *)message;
- (void)postError:(NSString *)message duration:(CGFloat)duration;
- (void)postError:(NSString *)message detailMessage:(NSString *)detailMessage duration:(CGFloat)duration;

#pragma mark - Loading
- (void)postProgress:(float)progress;
- (void)postLoading;
- (void)postLoading:(NSString *)message;
- (void)postLoading:(NSString *)title message:(NSString *)message;
- (void)postLoading:(NSString *)title message:(NSString *)message overTime:(NSTimeInterval)second;

#pragma mark - Hide
- (void)hideLoading;

@end
