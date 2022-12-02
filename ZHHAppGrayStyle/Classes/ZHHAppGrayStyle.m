//
//  ZHHAppGrayStyle.m
//  ZHHAppGrayStyle
//
//  Created by 桃色三岁 on 2022/12/2.
//  Copyright © 2022 桃色三岁. All rights reserved.
//

#import "ZHHAppGrayStyle.h"

@interface ZHHAppGrayStyleCoverView : UIView

@end

@implementation ZHHAppGrayStyleCoverView

+ (NSHashTable *)allCoverViews {
    static NSHashTable *array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = [NSHashTable weakObjectsHashTable];
    });
    return array;
}

+ (void)zhh_showInMaskerView:(UIView *)maskerView {
    if (@available(iOS 13, *)) {
        // 遍历是否已添加 gray cover view
        for (UIView *subview in maskerView.subviews) {
            if ([subview isKindOfClass:ZHHAppGrayStyleCoverView.class]) {
                return;
            }
        }
        
        ZHHAppGrayStyleCoverView *coverView = [[self alloc] initWithFrame:maskerView.bounds];
        coverView.userInteractionEnabled = NO;
        coverView.backgroundColor = [UIColor lightGrayColor];
        coverView.layer.compositingFilter = @"saturationBlendMode";
        coverView.layer.zPosition = FLT_MAX;
        [maskerView addSubview:coverView];
        
        [self.allCoverViews addObject:coverView];
    }
}

@end

@implementation ZHHAppGrayStyle
+ (void)zhh_open {
    NSAssert(NSThread.isMainThread, @"必须在主线程调用!");
    NSMutableSet *windows = [NSMutableSet set];
    [windows addObjectsFromArray:UIApplication.sharedApplication.windows];
    if (@available(iOS 13, *)) {
        for (UIWindowScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (![scene isKindOfClass:UIWindowScene.class]) {
                continue;
            }
            [windows addObjectsFromArray:scene.windows];
        }
    }
    // 遍历所有window，给它们加上蒙版
    for (UIWindow *window in windows) {
        NSString *className = NSStringFromClass(window.class);
        if (![className containsString:@"UIText"]) {
            [ZHHAppGrayStyleCoverView zhh_showInMaskerView:window];
        }
    }
}

+ (void)zhh_close {
    NSAssert(NSThread.isMainThread, @"必须在主线程调用!");
    for (UIView *coverView in ZHHAppGrayStyleCoverView.allCoverViews) {
        [coverView removeFromSuperview];
    }
}

+ (void)zhh_addToView:(UIView *)view {
    [ZHHAppGrayStyleCoverView zhh_showInMaskerView:view];
}

+ (void)zhh_removeFromView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:ZHHAppGrayStyleCoverView.class]) {
            [subview removeFromSuperview];
        }
    }
}
@end
