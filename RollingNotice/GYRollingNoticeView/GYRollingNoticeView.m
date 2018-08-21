//
//  GYRollingNoticeView.m
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GYRollingNoticeView.h"
#import "GYNoticeViewCell.h"


#define kGYNotiWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kGYNotiStrongSelf(type) __strong typeof(type) type = weak##type;

@interface GYRollingNoticeView ()


@property (nonatomic, strong) NSMutableDictionary *cellClsDict;
@property (nonatomic, strong) NSMutableArray *reuseCells;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) GYNoticeViewCell *currentCell;
@property (nonatomic, strong) GYNoticeViewCell *willShowCell;
@property (nonatomic, assign) BOOL isAnimating;


@end

@implementation GYRollingNoticeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupNoticeViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNoticeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupNoticeViews];
    }
    return self;
}

- (void)setupNoticeViews
{
    self.clipsToBounds = YES;
    _stayInterval = 2;
    [self addGestureRecognizer:[self createTapGesture]];
}



- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClsDict setObject:NSStringFromClass(cellClass) forKey:identifier];
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClsDict setObject:nib forKey:identifier];
}

- (__kindof GYNoticeViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    for (GYNoticeViewCell *cell in self.reuseCells) {
        
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
//            NSLog(@"finded reuse cell:  %p", cell);
            return cell;
        }
    }
    
    id cellClass = self.cellClsDict[identifier];
    if ([cellClass isKindOfClass:[UINib class]]) {
        UINib *nib = (UINib *)cellClass;
        
        NSArray *arr = [nib instantiateWithOwner:nil options:nil];
        GYNoticeViewCell *cell = [arr firstObject];
        [cell setValue:identifier forKeyPath:@"reuseIdentifier"];
        return cell;
    }else
    {
        Class cellCls = NSClassFromString(self.cellClsDict[identifier]);
        GYNoticeViewCell *cell = [[cellCls alloc] initWithReuseIdentifier:identifier];
        return cell;
    }
    
}


#pragma mark- rolling
- (void)layoutCurrentCellAndWillShowCell
{
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    
    int willShowIndex = _currentIndex + 1;
    if (willShowIndex > count - 1) {
        willShowIndex = 0;
    }
//    NSLog(@">>>>%d", _currentIndex);
    
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
//    NSLog(@"count: %d,  _currentIndex:%d  willShowIndex: %d", count, _currentIndex, willShowIndex);

    if (!_currentCell) {
        // 第一次没有currentcell
        // currentcell is null at first time
        _currentCell = [self.dataSource rollingNoticeView:self cellAtIndex:_currentIndex];
        _currentCell.frame  = CGRectMake(0, 0, w, h);
        [self addSubview:_currentCell];
        return;
    }
    
    
    
    _willShowCell = [self.dataSource rollingNoticeView:self cellAtIndex:willShowIndex];
    _willShowCell.frame = CGRectMake(0, h, w, h);
    [self addSubview:_willShowCell];
    
    
    if (GYRollingDebugLog) {
        NSLog(@"_currentCell  %p", _currentCell);
        NSLog(@"_willShowCell %p", _willShowCell);
    }

    [self.reuseCells removeObject:_currentCell];
    [self.reuseCells removeObject:_willShowCell];
    
    
}

- (void)reloadDataAndStartRoll
{
    [self stopRoll];

    [self layoutCurrentCellAndWillShowCell];
    NSInteger count = [self.dataSource numberOfRowsForRollingNoticeView:self];
    if (count && count < 2) {
        return;
    }
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_stayInterval target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopRoll
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _isAnimating = NO;
    _currentIndex = 0;
    [_currentCell removeFromSuperview];
    [_willShowCell removeFromSuperview];
    _currentCell = nil;
    _willShowCell = nil;
    [self.reuseCells removeAllObjects];
}

- (void)timerHandle
{
//    NSLog(@"-----------------------------------");
    
    if (self.isAnimating) return;
    
    [self layoutCurrentCellAndWillShowCell];
    _currentIndex ++;
    
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    self.isAnimating = YES;
    
    kGYNotiWeakSelf(self);
    [UIView animateWithDuration:0.5 animations:^{
        kGYNotiStrongSelf(self);
        
        self.currentCell.frame = CGRectMake(0, -h, w, h);
        self.willShowCell.frame = CGRectMake(0, 0, w, h);
    } completion:^(BOOL finished) {
        kGYNotiStrongSelf(self);
        
        // fixed bug: reload data when animate running
        if (self.currentCell && self.willShowCell) {
            [self.reuseCells addObject:self.currentCell];
            [self.currentCell removeFromSuperview];
            self.currentCell = self.willShowCell;
        }
        self.isAnimating = NO;
    }];
}


- (void)handleCellTapAction
{
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    if ([self.delegate respondsToSelector:@selector(didClickRollingNoticeView:forIndex:)]) {
        [self.delegate didClickRollingNoticeView:self forIndex:_currentIndex];
    }
}

- (UITapGestureRecognizer *)createTapGesture
{
   return [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTapAction)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{}

#pragma mark- lazy
- (NSMutableDictionary *)cellClsDict
{
    if (nil == _cellClsDict) {
        _cellClsDict = [[NSMutableDictionary alloc]init];
    }
    return _cellClsDict;
}

- (NSMutableArray *)reuseCells
{
    if (nil == _reuseCells) {
        _reuseCells = [[NSMutableArray alloc]init];
    }
    return _reuseCells;
}


@end
