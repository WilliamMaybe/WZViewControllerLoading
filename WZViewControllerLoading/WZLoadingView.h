//
//  WZLoadingView.h
//  launcher
//
//  Created by William Zhang on 15/7/24.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//  loading框

#import <UIKit/UIKit.h>

#define TipLoadingOverTime  60
#define TipNormalOverTime   1

@protocol WZLoadingViewDelegate <NSObject>

- (void)WZLoadingViewDelgateCallHubWasHidden;

@end

@interface WZLoadingView : UIView

/** 不显示任何提示（YES不显示） */
@property (nonatomic, assign) BOOL mute;

@property (nonatomic, weak) id <WZLoadingViewDelegate> delegate;

#pragma mark - Success
- (void)postSuccess:(NSString *)message overTime:(NSTimeInterval)second;

#pragma mark - Error
- (void)postError:(NSString *)message detailMessage:(NSString *)detailMessage duration:(CGFloat)duration;

#pragma mark - Loading
- (void)postProgress:(float)progress;
- (void)postLoading:(NSString *)title message:(NSString *)message overTime:(NSTimeInterval)second;

#pragma mark - Hide
- (void)hide:(BOOL)animated;

@end
