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

{
    int _cIdx;
    BOOL _needTryRoll;
}

@property (nonatomic, strong) NSMutableDictionary *cellClsDict;
@property (nonatomic, strong) NSMutableArray *reuseCells;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) GYNoticeViewCell *currentCell;
@property (nonatomic, strong) GYNoticeViewCell *willShowCell;
@property (nonatomic, assign) BOOL isAnimating;


@end

@implementation GYRollingNoticeView
@dynamic currentIndex;

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_needTryRoll) {
        [self reloadDataAndStartRoll];
        _needTryRoll = NO;
    }
    
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
    if (_cIdx > count - 1) {
        _cIdx = 0;
    }
    
    int willShowIndex = _cIdx + 1;
    if (willShowIndex > count - 1) {
        willShowIndex = 0;
    }
//    NSLog(@">>>>%d", _cIdx);
    
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
//    NSLog(@"count: %d,  _cIdx:%d  willShowIndex: %d", count, _cIdx, willShowIndex);

    if (!(w > 0 && h > 0)) {
        _needTryRoll = YES;
        return;
    }
    if (!_currentCell) {
        // 第一次没有currentcell
        // currentcell is null at first time
        _currentCell = [self.dataSource rollingNoticeView:self cellAtIndex:_cIdx];
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

    NSInteger count = [self.dataSource numberOfRowsForRollingNoticeView:self];
    if (count < 1) {
        return;
    }
    
    [self layoutCurrentCellAndWillShowCell];
    
    if (count && count < 2) {
        return;
    }
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_stayInterval target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    [self resume];
}

- (void)stopRoll
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _status = GYRollingNoticeViewStatusIdle;
    _isAnimating = NO;
    _cIdx = 0;
    [_currentCell removeFromSuperview];
    [_willShowCell removeFromSuperview];
    _currentCell = nil;
    _willShowCell = nil;
    [self.reuseCells removeAllObjects];
}

- (void)pause
{
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
        _status = GYRollingNoticeViewStatusPause;
    }
}
- (void)resume
{
    if (_timer) {
        [_timer setFireDate:[NSDate distantPast]];
        _status = GYRollingNoticeViewStatusWorking;
    }
}

- (void)timerHandle
{
//    NSLog(@"-----------------------------------");
    
    if (self.isAnimating) return;
    
    [self layoutCurrentCellAndWillShowCell];
    
    
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
        
        self -> _cIdx ++;
    }];
}


- (void)handleCellTapAction
{
    if ([self.delegate respondsToSelector:@selector(didClickRollingNoticeView:forIndex:)]) {
        [self.delegate didClickRollingNoticeView:self forIndex:self.currentIndex];
    }
}

- (UITapGestureRecognizer *)createTapGesture
{
   return [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTapAction)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{}


#pragma mark-

- (int)currentIndex {
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_cIdx > count - 1) {
        _cIdx = 0;
    }
    return _cIdx;
}


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
