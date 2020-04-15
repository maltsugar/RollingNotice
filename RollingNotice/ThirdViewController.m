//
//  ThirdViewController.m
//  RollingNotice
//
//  Created by zgy on 2020/4/15.
//  Copyright © 2020 qm. All rights reserved.
//

#import "ThirdViewController.h"
#import "DemoCodeAutoLayout.h"
#import "GYRollingNoticeView.h"

@interface ThirdViewController ()<GYRollingNoticeViewDataSource, GYRollingNoticeViewDelegate>

{
    NSArray *_arr;
    
}
@property (nonatomic, strong) GYRollingNoticeView *noticeView;
@end

@implementation ThirdViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _arr = @[@"小米千元全面屏：抱歉，久等！625献上",
//                 @"可怜狗狗被抛弃，苦苦等候主人半年",
//                 @"三星中端新机改名，全面屏火力全开",
//                 @"学会这些，这5种花不用去花店买了",
//                 @"华为nova2S发布，剧透了荣耀10？"
        ];
        
        
        _noticeView = [[GYRollingNoticeView alloc] init];
        _noticeView.delegate = self;
        _noticeView.dataSource = self;
        
        [self.view addSubview:_noticeView];
        
        
        [_noticeView registerClass:[DemoCodeAutoLayout class] forCellReuseIdentifier:@"DemoCodeAutoLayout"];
        
        [_noticeView reloadDataAndStartRoll];
        
        _noticeView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-160-[v]" options:0 metrics:nil views:@{@"v": _noticeView}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[v]-20-|" options:0 metrics:nil views:@{@"v": _noticeView}]];
        
        [_noticeView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v(30)]" options:0 metrics:nil views:@{@"v": _noticeView}]];
      
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_noticeView stopRoll];
}


#pragma mark- <GYRollingNoticeViewDataSource, GYRollingNoticeViewDelegate>
- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
    return _arr.count;
}
- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    DemoCodeAutoLayout *cell = [rollingView dequeueReusableCellWithIdentifier:@"DemoCodeAutoLayout"];
    cell.customLab.text = _arr[index];
    return cell;
    
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    NSLog(@"点击的index: %d", rollingView.currentIndex);
}

@end
