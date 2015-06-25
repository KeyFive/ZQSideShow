//
//  ZQSideShowHelper.h
//  ZQSideViewDemo
//
//  Created by zhiqiangcao on 15/6/15.
//  Copyright (c) 2015年 CZQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZQSideShowProtocol.h"

typedef void (^ZQVoidBlock)();

typedef NS_ENUM(NSInteger, ZQShowEdge)
{
    ZQShowEdgeLeft,
    ZQShowEdgeLeftUp,
    ZQShowEdgeRight,
    ZQShowEdgeRightUp
};

@interface ZQSideShowHelper : NSObject

@property (nonatomic, assign) NSTimeInterval animationDuration;//动画时长
@property (nonatomic, strong) ZQVoidBlock dismissBlock;
@property (nonatomic, weak) id<ZQSideShowProtocol> delegate;

/**
 *  指定初始化方法
 *
 *  @param showInView 视图展示容器
 *
 *  @return ZQSideShowHelper实例
 */
- (instancetype)initWithShowInView:(UIView *)showInView;

/**
 *  show视图
 *
 *  @param view 展示的视图
 *  @param edge 从哪个方向展示视图
 */
- (void)showView:(UIView *)view fromEdge:(ZQShowEdge)edge;

/**
 *  隐藏展示出来的视图
 */
- (void)hideShowView;

@end
