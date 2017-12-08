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
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
        self.backgroundColor = [UIColor whiteColor];
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
        
        _reuseIdentifier = reuseIdentifier;
        _textLabel = [[UILabel alloc]init];
        [_contentView addSubview:_textLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
       
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
    _textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}




@end
