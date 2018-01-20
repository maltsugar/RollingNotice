//
//  GYRollingNoticeView.h
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYNoticeViewCell.h"

@class GYRollingNoticeView;
@protocol GYRollingNoticeViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView;
- (GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index;
@end

@protocol GYRollingNoticeViewDelegate <NSObject>
@optional
- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index;

@end



@interface GYRollingNoticeView : UIView


@property (nonatomic, assign) id<GYRollingNoticeViewDataSource> dataSource;
@property (nonatomic, assign) id<GYRollingNoticeViewDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval stayInterval; // 停留时间 默认2秒

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;
- (__kindof GYNoticeViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (void)reloadDataAndStartRoll;
- (void)stopRoll; // 在合适的地方停止timer。 you must stop it when not use,for example '-viewDidDismiss'


@end
