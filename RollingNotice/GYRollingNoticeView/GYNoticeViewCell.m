//
//  GYNoticeViewCell.m
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GYNoticeViewCell.h"

@implementation GYNoticeViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        NSLog(@"%s", __func__);
        _reuseIdentifier = reuseIdentifier;
        [self setupInitialUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithReuseIdentifier:@""];
}

- (void)setupInitialUI
{
    self.backgroundColor = [UIColor whiteColor];
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    _textLabel = [[UILabel alloc]init];
    [_contentView addSubview:_textLabel];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
    _textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}




@end
