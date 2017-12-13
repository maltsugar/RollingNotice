//
//  DemoCell2.m
//  RollingNotice
//
//  Created by qm on 2017/12/13.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "DemoCell2.h"

@interface DemoCell2 ()

@property (nonatomic, strong) UIButton *testBtn;



@end

@implementation DemoCell2

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

// cell 高度30
- (void)setupUI
{
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [self.contentView addSubview:testBtn];
    testBtn.frame = CGRectMake(10, 5, 20, 20);
    
    _customLab = [[UILabel alloc]initWithFrame:CGRectMake(30+10, 5, 200, 20)];
    _customLab.textColor = [UIColor redColor];
    _customLab.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_customLab];
}

@end
