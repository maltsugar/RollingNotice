//
//  SecondViewController.m
//  RollingNotice
//
//  Created by qm on 2018/8/7.
//  Copyright © 2018年 qm. All rights reserved.
//

#import "SecondViewController.h"
#import "GYRollingNoticeView.h"

@interface SecondViewController ()<GYRollingNoticeViewDataSource, GYRollingNoticeViewDelegate>

{
    NSArray *_arr;
    
}

@property (weak, nonatomic) IBOutlet GYRollingNoticeView *noticeView;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _arr = @[@"小米千元全面屏：抱歉，久等！625献上",
              @"可怜狗狗被抛弃，苦苦等候主人半年",
              @"三星中端新机改名，全面屏火力全开",
              @"学会这些，这5种花不用去花店买了",
              @"华为nova2S发布，剧透了荣耀10？"
              ];
    
    _noticeView.delegate = self;
    _noticeView.dataSource = self;
    [_noticeView registerClass:[GYNoticeViewCell class] forCellReuseIdentifier:@"GYNoticeViewCell"];
    
    [_noticeView reloadDataAndStartRoll];
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
    GYNoticeViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"GYNoticeViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"index %d ,%@", (int)index, _arr[index]];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    cell.textLabelLeading = 100;
    cell.textLabelTrailing = 80;
    if (index % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor greenColor];
        cell.textLabelLeading = 0;
    }
    return cell;
    
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    NSLog(@"点击的index: %d", rollingView.currentIndex);
}











- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
