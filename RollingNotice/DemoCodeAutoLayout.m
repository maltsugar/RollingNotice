//
//  DemoCodeAutoLayout.m
//  RollingNotice
//
//  Created by zgy on 2020/4/15.
//  Copyright © 2020 qm. All rights reserved.
//

#import "DemoCodeAutoLayout.h"

@implementation DemoCodeAutoLayout

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
    //    testBtn.frame = CGRectMake(10, 5, 20, 20);
    testBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]" options:0 metrics:nil views:@{@"v": testBtn}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]" options:0 metrics:nil views:@{@"v": testBtn}]];
    
    [testBtn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v(30)]" options:0 metrics:nil views:@{@"v": testBtn}]];
    [testBtn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[v(60)]" options:0 metrics:nil views:@{@"v": testBtn}]];
    
    
    
    _customLab = [[UILabel alloc]init];
    _customLab.textColor = [UIColor redColor];
    _customLab.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_customLab];
    
    _customLab.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|" options:0 metrics:nil views:@{@"v": _customLab}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[v]" options:0 metrics:nil views:@{@"v": _customLab}]];
     [_customLab addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[v(160)]" options:0 metrics:nil views:@{@"v": _customLab}]];
    
    
}

@end
