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
#import "DemoCell2.h"
#import "DemoCell3.h"
#import "SecondViewController.h"


@interface ViewController ()<GYRollingNoticeViewDataSource, GYRollingNoticeViewDelegate>
{
    NSArray *_arr0;
    NSArray *_arr1;
    
    GYRollingNoticeView *_noticeView0;
    GYRollingNoticeView *_noticeView1;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float w = [[UIScreen mainScreen] bounds].size.width;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, w, 100)];
    lab.numberOfLines = 0;
    lab.text = @"滚动公告、广告，支持自定义cell，模仿淘宝头条等等。 \nUITableViewCell重用理念，支持请Star!";
    [self.view addSubview:lab];
    
    
    
    _arr0 = @[
              @{@"arr": @[@{@"tag": @"手机", @"title": @"小米千元全面屏：抱歉，久等！625献上"}, @{@"tag": @"萌宠", @"title": @"可怜狗狗被抛弃，苦苦等候主人半年"}], @"img": @"tb_icon2"},
              @{@"arr": @[@{@"tag": @"手机", @"title": @"三星中端新机改名，全面屏火力全开"}, @{@"tag": @"围观", @"title": @"主人假装离去，狗狗直接把孩子推回去了"}], @"img": @"tb_icon3"},
              @{@"arr": @[@{@"tag": @"园艺", @"title": @"学会这些，这5种花不用去花店买了"}, @{@"tag": @"手机", @"title": @"华为nova2S发布，剧透了荣耀10？"}], @"img": @"tb_icon5"},
              @{@"arr": @[@{@"tag": @"开发", @"title": @"iOS 内购最新讲解"}, @{@"tag": @"博客", @"title": @"技术博客那些事儿"}], @"img": @"tb_icon6"},
              @{@"arr": @[@{@"tag": @"招聘", @"title": @"招聘XX高级开发工程师"}, @{@"tag": @"资讯", @"title": @"如何写一篇好的技术博客"}], @"img": @"tb_icon7"}
              ];
    _arr1 = @[@"小米千元全面屏：抱歉，久等！625献上",
              @"可怜狗狗被抛弃，苦苦等候主人半年",
              @"三星中端新机改名，全面屏火力全开",
              @"学会这些，这5种花不用去花店买了",
              @"华为nova2S发布，剧透了荣耀10？"
              ];
    
    [self creatRollingViewWithArray:_arr0 isFirst:YES];
    [self creatRollingViewWithArray:_arr1 isFirst:NO];
    
    
    // 刷新数据源  reload datasource test ok
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _arr1 = @[@"0", @"1", @"2", @"3", @"4", @"5"];
////        _arr1 = @[@"0"];
//        [_noticeView1 reloadDataAndStartRoll];
//    });

}

// 请在合适的时机 停止
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_noticeView0 stopRoll];
    [_noticeView1 stopRoll];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_noticeView0 reloadDataAndStartRoll];
}


- (void)creatRollingViewWithArray:(NSArray *)arr isFirst:(BOOL)isFirst
{
    float w = [[UIScreen mainScreen] bounds].size.width;
    CGRect frame = CGRectMake(0, 190, w, 50);
    if (!isFirst) {
        frame = CGRectMake(0, 290, w, 30);
    }
    
    GYRollingNoticeView *noticeView = [[GYRollingNoticeView alloc]initWithFrame:frame];
    noticeView.dataSource = self;
    noticeView.delegate = self;
    [self.view addSubview:noticeView];
    noticeView.backgroundColor = [UIColor lightGrayColor];
    
    if (isFirst) {
        _noticeView0 = noticeView;
        [noticeView registerNib:[UINib nibWithNibName:@"CustomNoticeCell" bundle:nil] forCellReuseIdentifier:@"CustomNoticeCell"];
        [noticeView registerNib:[UINib nibWithNibName:@"DemoCell3" bundle:nil] forCellReuseIdentifier:@"DemoCell3"];
        
    }else{
        _noticeView1 = noticeView;
        [noticeView registerClass:[GYNoticeViewCell class] forCellReuseIdentifier:@"GYNoticeViewCell"];
        [noticeView registerClass:[DemoCell2 class] forCellReuseIdentifier:@"DemoCell2"];
    }
    
    [noticeView reloadDataAndStartRoll];
}



- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
    if (rollingView == _noticeView0) {
        return _arr0.count;
    }
    
    if (rollingView == _noticeView1) {
        return _arr1.count;
    }
    
    return 0;
}
- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    if (rollingView == _noticeView0) {

        if (index < 3) {
            CustomNoticeCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"CustomNoticeCell"];
            [cell noticeCellWithArr:_arr0 forIndex:index];
            return cell;
        }else
        {
            DemoCell3 *cell = [rollingView dequeueReusableCellWithIdentifier:@"DemoCell3"];
            NSDictionary *dic = _arr0[index];
            cell.lab0.text = [dic[@"arr"] firstObject][@"title"];
            cell.lab1.text = [dic[@"arr"] lastObject][@"title"];
            return cell;
        }
        
        
        
    }
    
    // 普通用法，只有一行label滚动显示文字
    // normal use, only one line label rolling
    if (rollingView == _noticeView1) {
        if (index < 3) {
            GYNoticeViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"GYNoticeViewCell"];
            cell.textLabel.text = [NSString stringWithFormat:@"第1种cell %@", _arr1[index]];
            cell.contentView.backgroundColor = [UIColor orangeColor];
            if (index % 2 == 0) {
                cell.contentView.backgroundColor = [UIColor greenColor];
            }
            return cell;
        }else {
            
            DemoCell2 *cell = [rollingView dequeueReusableCellWithIdentifier:@"DemoCell2"];
            cell.customLab.text = [NSString stringWithFormat:@"第2种cell %@", _arr1[index]];
            cell.contentView.backgroundColor = [UIColor purpleColor];
            return cell;
        }
        
        
    }
    
    
    return nil;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    NSLog(@"点击的index: %lu", (unsigned long)index);
}

- (IBAction)handleRightAction:(UIBarButtonItem *)sender
{
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
