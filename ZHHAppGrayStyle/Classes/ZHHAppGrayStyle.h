//
//  ZHHAppGrayStyle.h
//  ZHHAppGrayStyle
//
//  Created by 桃色三岁 on 2022/12/2.
//  Copyright © 2022 桃色三岁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHHAppGrayStyle : NSObject
/// 开启全局变灰
+ (void)zhh_open;
/// 关闭全局变灰
+ (void)zhh_close;
/// 添加灰色模式
+ (void)zhh_addToView:(UIView *)view;
/// 移除灰色模式
+ (void)zhh_removeFromView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
