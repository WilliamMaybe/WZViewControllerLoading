//
//  WZLoadingView.m
//  launcher
//
//  Created by William Zhang on 15/7/24.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import "WZLoadingView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>

@interface WZLoadingView () <MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, getter=isLoading) BOOL loading;

@end

@implementation WZLoadingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initComponents];
        self.frame = [[UIScreen mainScreen] bounds];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (void)initComponents
{
    [self addSubview:self.HUD];
    self.backgroundColor = [UIColor clearColor];

    [self initConstraints];
}

- (void)initConstraints {
    [self.HUD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)dealloc {
    self.HUD.delegate = nil;
    self.delegate = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimerCallBack) object:nil];
}

#pragma mark - Success
- (void)postSuccess:(NSString *)message overTime:(NSTimeInterval)second {
    if (self.mute) {
        return;
    }
    
    self.loading = NO;
    
    UIImage *msgImg = [UIImage imageNamed:@"HUD_Success"];
    UIImageView *msgImgView = [[UIImageView alloc] initWithImage:msgImg];
    self.HUD.customView = msgImgView;
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.detailsLabelText = message;
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:16];
    [self.HUD show:YES];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimerCallBack) object:nil];
    [self performSelector:@selector(overTimerCallBack) withObject:nil afterDelay:second];
}

#pragma mark - Error
- (void)postError:(NSString *)message detailMessage:(NSString *)detailMessage duration:(CGFloat)duration {
    if (self.mute) {
        return;
    }
    
    self.loading = NO;
    // 无文字不显示
    if (![message length] && ![detailMessage length]) {
        [self hide:NO];
        return;
    }
    
    UIImage *msgImg = [UIImage imageNamed:@"HUD_Error"];
    UIImageView *msgImgView = [[UIImageView alloc] initWithImage:msgImg];
    self.HUD.customView = msgImgView;
    self.HUD.mode = MBProgressHUDModeCustomView;
    
    if (!detailMessage.length) {
        detailMessage = message;
    }
    
    self.HUD.detailsLabelText = detailMessage;
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:16];
    [self.HUD show:YES];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimerCallBack) object:nil];
    [self performSelector:@selector(overTimerCallBack) withObject:nil afterDelay:duration];
}

#pragma mark - Loading
- (void)postProgress:(float)progress {
    if (self.mute) {
        return;
    }
    
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
    self.HUD.progress = progress;
    [self.HUD show:YES];
}

- (void)postLoading {
    [self postLoading:@""];
}

- (void)postLoading:(NSString *)message {
    [self postLoading:message message:@""];
}

- (void)postLoading:(NSString *)title message:(NSString *)message {
    [self postLoading:title message:message overTime:TipLoadingOverTime];
}

- (void)postLoading:(NSString *)title message:(NSString *)message overTime:(NSTimeInterval)second {
    if (self.mute) {
        return;
    }
    
    if (self.isLoading && [self.HUD.labelText isEqualToString:message]) {
        return;
    }
    
    self.loading = YES;
    self.HUD.customView = nil;
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = title;
    self.HUD.detailsLabelText = message;
    [self.HUD show:YES];
    [self performSelector:@selector(overTimerCallBack) withObject:nil afterDelay:second];
}

#pragma mark - Hide
- (void)hide:(BOOL)animated {
    self.loading = NO;
    [self.HUD hide:animated];
    self.delegate = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimerCallBack) object:nil];
}

- (void)overTimerCallBack {
    [self hide:NO];
}

#pragma mark - MBProgressHUD Delegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (self.delegate && [self.delegate respondsToSelector:@selector(WZLoadingViewDelgateCallHubWasHidden)]) {
        [self.delegate WZLoadingViewDelgateCallHubWasHidden];
    }
}

#pragma mark - Initializer
- (MBProgressHUD *)HUD {
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        _HUD.animationType = MBProgressHUDAnimationFade;
        _HUD.delegate = self;
        _HUD.mode = MBProgressHUDModeText;
    }
    return _HUD;
}

@end
