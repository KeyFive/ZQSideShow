//
//  ShowViewController.m
//  ZQSideViewDemo
//
//  Created by zhiqiangcao on 15/6/1.
//  Copyright (c) 2015年 CZQ. All rights reserved.
//

#import "ShowViewController.h"
#import "ZQSideShowHelper.h"

@interface ShowViewController ()

@property (nonatomic, strong) ZQSideShowHelper *helper;

@property (weak, nonatomic) IBOutlet UIButton *leftButtpn;
@property (weak, nonatomic) IBOutlet UIButton *leftUpButton;
@property (weak, nonatomic) IBOutlet UIButton *rightUpButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (nonatomic, strong) UIView *showTestView;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - property

- (ZQSideShowHelper *)helper
{
    if (!_helper)
    {
        _helper = [[ZQSideShowHelper alloc] initWithShowInView:self.view];
    }
    return _helper;
}

- (UIView *)showTestView
{
    if (!_showTestView)
    {
        _showTestView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _showTestView.backgroundColor = [UIColor redColor];
    }
    return _showTestView;
}

#pragma mark - methods
- (IBAction)showSideView:(id)sender
{
    if ([sender isEqual:self.leftButtpn])
    {
        [self.helper showView:self.showTestView fromEdge:ZQShowEdgeLeft];
    }
    else if ([sender isEqual:self.leftUpButton])
    {
        [self.helper showView:self.showTestView fromEdge:ZQShowEdgeLeftUp];
    }
    else if ([sender isEqual:self.rightUpButton])
    {
        [self.helper showView:self.showTestView fromEdge:ZQShowEdgeRightUp];
    }
    else if ([sender isEqual:self.rightButton])
    {
        [self.helper showView:self.showTestView fromEdge:ZQShowEdgeRight];
    }
}

@end
