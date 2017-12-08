//
//  ViewController.m
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "ViewController.h"
#import "GYRollingNoticeView.h"
#import "CustomNoticeCell.h"

@interface ViewController ()<GYRollingNoticeViewDataSource, GYRollingNoticeViewDelegate>
{
    NSArray *_arr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    CGRect frame = CGRectMake(0, 80, 414, 40);
    GYRollingNoticeView *noticeView = [[GYRollingNoticeView alloc]initWithFrame:frame];
    noticeView.dataSource = self;
    noticeView.delegate = self;
    [self.view addSubview:noticeView];
    noticeView.backgroundColor = [UIColor lightGrayColor];
    [noticeView registerClass:[GYNoticeViewCell class] forCellReuseIdentifier:@"GYNoticeViewCell"];
    [noticeView registerNib:[UINib nibWithNibName:@"CustomNoticeCell" bundle:nil] forCellReuseIdentifier:@"CustomNoticeCell"];
    
    _arr = @[@"0", @"1", @"2", @"3", @"4", @"5"];
    
    [noticeView beginScroll];

}



- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
    return _arr.count;
}
- (GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    CustomNoticeCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"CustomNoticeCell"];
    return cell;
    
    
    
    
//    GYNoticeViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"GYNoticeViewCell"];
//    cell.textLabel.text = _arr[index];
//    cell.contentView.backgroundColor = [UIColor orangeColor];
//    if (index % 2 == 0) {
//        cell.contentView.backgroundColor = [UIColor greenColor];
//    }
//    return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    
}


@end
