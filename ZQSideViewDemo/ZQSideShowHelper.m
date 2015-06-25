//
//  ZQSideShowHelper.m
//  ZQSideViewDemo
//
//  Created by zhiqiangcao on 15/6/15.
//  Copyright (c) 2015年 CZQ. All rights reserved.
//

#import "ZQSideShowHelper.h"

@interface ZQSideShowHelper()

@property (nonatomic, strong) UIView *showInView;
@property (nonatomic, strong) UIView *showBackView;//背景
@property (nonatomic, strong) UIView *dismissView;//背景遮罩
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, assign) ZQShowEdge showEdge;

@end

@implementation ZQSideShowHelper

#pragma mark - init function

- (instancetype)initWithShowInView:(UIView *)showInView
{
    self = [super init];
    if (self)
    {
        NSAssert(showInView, @"showInView不能为nil");
        self.animationDuration = 0.3;
        self.showInView = showInView;
    }
    return self;
}

#pragma mark - property

- (UIView *)showBackView
{
    if (!_showBackView)
    {
        _showBackView = [[UIView alloc] initWithFrame:self.showInView.bounds];
        _showBackView.backgroundColor = [UIColor clearColor];
        _showBackView.userInteractionEnabled = YES;
    }
    return _showBackView;
}

- (UIView *)dismissView
{
    if (!_dismissView)
    {
        _dismissView = [[UIView alloc] initWithFrame:self.showInView.bounds];
        _dismissView.userInteractionEnabled = YES;
        _dismissView.backgroundColor = [UIColor blackColor];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismissView:)];
        [_dismissView addGestureRecognizer:tap];
    }
    return _dismissView;
}

#pragma mark - target action

- (void)tapDismissView:(UITapGestureRecognizer *)tap
{
    if (self.dismissBlock)
    {
        self.dismissBlock();
    }
    else
    {
        [self hideShowView];
    }
}

#pragma mark - interface methods

- (void)showView:(UIView *)view fromEdge:(ZQShowEdge)edge
{
    self.showView = view;
    self.showEdge = edge;
    CGPoint showViewBeginOrigin = [self beginOriginForShowView:view withEdge:edge];
    CGPoint showViewEndOrigin = [self endOriginForShowView:view withEdge:edge];
    [self resetStateForShowView:view];
    view.frame = CGRectMake(showViewBeginOrigin.x, showViewBeginOrigin.y, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    self.dismissView.alpha = 0;
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.dismissView.alpha = 0.3;
        view.frame = CGRectMake(showViewEndOrigin.x, showViewEndOrigin.y, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    } completion:^(BOOL finished) {
        if ([weakSelf.delegate respondsToSelector:@selector(sideViewShowSuccessed)])
        {
            [weakSelf.delegate sideViewShowSuccessed];
        }
    }];
}

- (void)hideShowView
{
    CGPoint showViewBeginOrigin = [self beginOriginForShowView:self.showView withEdge:self.showEdge];
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.dismissView.alpha = 0;
        weakSelf.showView.frame = CGRectMake(showViewBeginOrigin.x, showViewBeginOrigin.y, CGRectGetWidth(weakSelf.showView.frame), CGRectGetHeight(weakSelf.showView.frame));
    } completion:^(BOOL finished) {
        [weakSelf.showBackView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
        weakSelf.showView = nil;
        [weakSelf.showBackView removeFromSuperview];
    }];
}

#pragma  mark - customer methods

- (void)resetStateForShowView:(UIView *)showView
{
    self.dismissView.alpha = 0;
    [self.showInView addSubview:self.showBackView];
    [self.showBackView addSubview:self.dismissView];
    [self.showBackView addSubview:showView];
}

- (CGPoint)beginOriginForShowView:(UIView *)showView withEdge:(ZQShowEdge)edge
{
    CGPoint beginOrigin = CGPointZero;
    switch (edge)
    {
        case ZQShowEdgeLeft:
            beginOrigin = CGPointMake(-CGRectGetWidth(showView.frame), 0);
            break;
        case ZQShowEdgeLeftUp:
            beginOrigin = CGPointMake(0, -CGRectGetHeight(showView.frame));
            break;
        case ZQShowEdgeRight:
            beginOrigin = CGPointMake(CGRectGetWidth(self.showInView.frame), 0);
            break;
        case ZQShowEdgeRightUp:
            beginOrigin = CGPointMake(CGRectGetWidth(self.showInView.frame) - CGRectGetWidth(showView.frame), -CGRectGetHeight(showView.frame));
            break;
        default:
            break;
    }
    return beginOrigin;
}

- (CGPoint)endOriginForShowView:(UIView *)showView withEdge:(ZQShowEdge)edge
{
    CGPoint endOrigin = CGPointZero;
    switch (edge)
    {
        case ZQShowEdgeLeft:
            break;
        case ZQShowEdgeLeftUp:
            break;
        case ZQShowEdgeRight:
        case ZQShowEdgeRightUp:
            endOrigin = CGPointMake(CGRectGetWidth(self.showInView.frame) - CGRectGetWidth(showView.frame), 0);
            break;
        default:
            break;
    }
    return endOrigin;
}

@end
