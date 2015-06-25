//
//  ZQSideShowProtocol.h
//  ZQSideViewDemo
//
//  Created by zhiqiangcao on 15/6/16.
//  Copyright (c) 2015年 CZQ. All rights reserved.
//

#ifndef ZQSideViewDemo_ZQSideShowProtocol_h
#define ZQSideViewDemo_ZQSideShowProtocol_h

@protocol ZQSideShowProtocol <NSObject>

@optional
- (void)sideViewShowSuccessed;
- (void)sideViewHideSuccessed;

@end

#endif
