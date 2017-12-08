//
//  CustomNoticeCell.m
//  RollingNotice
//
//  Created by qm on 2017/12/8.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "CustomNoticeCell.h"
@interface CustomNoticeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *trailIconImgView;

@property (weak, nonatomic) IBOutlet UILabel *tagLab0;
@property (weak, nonatomic) IBOutlet UILabel *titleLab0;

@property (weak, nonatomic) IBOutlet UILabel *tagLab1;
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;


@end
@implementation CustomNoticeCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _tagLab0.layer.borderColor = [UIColor orangeColor].CGColor;
    _tagLab0.layer.borderWidth = 0.5;
    _tagLab0.layer.cornerRadius = 3;
    
    _tagLab1.layer.borderColor = [UIColor orangeColor].CGColor;
    _tagLab1.layer.borderWidth = 0.5;
    _tagLab1.layer.cornerRadius = 3;
}


- (void)noticeCellWithArr:(NSArray *)arr forIndex:(NSUInteger)index
{
    NSDictionary *dic = arr[index];
    _trailIconImgView.image = [UIImage imageNamed:dic[@"img"]];
    
    _tagLab0.text = [dic[@"arr"] firstObject][@"tag"];
    _titleLab0.text = [dic[@"arr"] firstObject][@"title"];
    
    _tagLab1.text = [dic[@"arr"] lastObject][@"tag"];
    _titleLab1.text = [dic[@"arr"] lastObject][@"title"];
    
}


@end
