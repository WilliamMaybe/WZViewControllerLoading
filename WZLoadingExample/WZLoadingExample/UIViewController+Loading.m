//
//  UIViewController+Loading.m
//  launcher
//
//  Created by williamzhang on 15/11/24.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "WZLoadingView.h"
#import <objc/runtime.h>

@interface UIViewController (loadingView) <WZLoadingViewDelegate>

@property (nonatomic, strong) WZLoadingView *loadingView;

@end

@implementation UIViewController (loadingView)

- (WZLoadingView *)loadingView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLoadingView:(WZLoadingView *)loadingView {
    objc_setAssociatedObject(self, @selector(loadingView), loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - WZLoadingView Delegate
- (void)WZLoadingViewDelgateCallHubWasHidden {
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
        self.loadingView.delegate = nil;
        self.loadingView = nil;
    }
}

@end

@implementation UIViewController (Loading)

- (BOOL)wz_loading {
    return self.loadingView && !self.loadingView.hidden;
}

- (BOOL)wz_loadingInteractionEnabled {
    id value = objc_getAssociatedObject(self, _cmd);
    return value ? [value boolValue] : NO;
}

- (void)setWz_loadingInteractionEnabled:(BOOL)wz_loadingInteractionEnabled {
    objc_setAssociatedObject(self, @selector(wz_loadingInteractionEnabled), @(wz_loadingInteractionEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configureLoading {
    if (!self.loadingView) {
        self.loadingView = [[WZLoadingView alloc] initWithFrame:self.view.bounds];
        self.loadingView.userInteractionEnabled = self.wz_loadingInteractionEnabled;
        self.loadingView.delegate = self;
        [self.view addSubview:self.loadingView];
    }
    [self.view bringSubviewToFront:self.loadingView];
}

#pragma mark - WZLoadingView Success
- (void)wz_postSuccess                     { [self wz_postSuccess:@""];}
- (void)wz_postSuccess:(NSString *)message { [self wz_postSuccess:message overTime:TipNormalOverTime];}
- (void)wz_postSuccess:(NSString *)message overTime:(NSTimeInterval)second {
    [self configureLoading];
    [self.loadingView postSuccess:message overTime:second];
}

#pragma mark - WZLoadingView Error
- (void)wz_postError:(NSString *)message                            { [self wz_postError:message detailMessage:@"" duration:TipNormalOverTime];}
- (void)wz_postError:(NSString *)message duration:(CGFloat)duration { [self wz_postError:message detailMessage:@"" duration:duration];}
- (void)wz_postError:(NSString *)message detailMessage:(NSString *)detailMessage duration:(CGFloat)duration {
    [self configureLoading];
    [self.loadingView postError:message detailMessage:detailMessage duration:duration];
}

#pragma mark - WZLoadingView Loading
- (void)wz_postProgress:(float)progress {
    [self.loadingView postProgress:progress];
}

- (void)wz_postLoading                                               { [self wz_postLoading:@""];}
- (void)wz_postLoading:(NSString *)message                           { [self wz_postLoading:message message:@""];}
- (void)wz_postLoading:(NSString *)title message:(NSString *)message { [self wz_postLoading:title message:message overTime:TipLoadingOverTime];}
- (void)wz_postLoading:(NSString *)title message:(NSString *)message overTime:(NSTimeInterval)second {
    [self configureLoading];
    [self.loadingView postLoading:title message:message overTime:second];
}


#pragma mark - WZLoadingView Hide
- (void)wz_hideLoading {
    if (self.loadingView) {
        [self.loadingView hide:NO];
        [self WZLoadingViewDelgateCallHubWasHidden];
    }
}

@end
