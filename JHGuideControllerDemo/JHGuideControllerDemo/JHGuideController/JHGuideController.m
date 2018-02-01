//
//  JHGuideController.m
//  Demo
//
//  Created by JasonHu on 2018/1/25.
//  Copyright © 2018年 JasonHu. All rights reserved.
//

#import "JHGuideController.h"

@interface JHGuideController ()

@property (nonatomic, strong) NSMutableArray *rectArray;
@property (nonatomic, strong) NSMutableArray *snapShotViewArray;
@property (nonatomic, strong) NSMutableArray *originalViewArray;


@end

@implementation JHGuideController

- (void)dismiss
{
    [self.guideWindow resignKeyWindow];
    self.guideWindow = nil;
}

// 通过复制view实现效果
- (void)showWithViewToSnapshot:(UIView *)view 
{
    [self showWithViewsToSnapshot:@[view]];
    
}

// 通过复制view实现效果
- (void)showWithViewsToSnapshot:(NSArray<__kindof UIView *> *)array
{
    //
    [self addWindow];
    
    //
    [self.snapShotViewArray removeAllObjects];
    [self.originalViewArray removeAllObjects];
    
    for (UIView *view in array) {
        
        UIView *snapshotView = [view snapshotViewAfterScreenUpdates:self.snapshotViewUpdates];
        snapshotView.frame = [view.window convertRect:[view convertRect:view.bounds toView:view.window] toWindow:self.guideWindow];
        [self.view addSubview:snapshotView];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(snapshotViewTapAction:)];
        [snapshotView addGestureRecognizer:tapGR];
        
        [self.snapShotViewArray addObject:snapshotView];
        [self.originalViewArray addObject:view];
    }
    
}

- (UIView *)snapShotViewForView:(UIView *)view
{
    if ([self.originalViewArray containsObject:view]) {
        
        return [self.snapShotViewArray objectAtIndex:[self.originalViewArray indexOfObject:view]];
        
    } else {
        return nil;
    }
}

// --

// 通过镂空半透明浮层实现效果
- (void)showWithRectToHollow:(CGRect)rect
{
    [self showWithRectsToHollow:@[[NSValue valueWithCGRect:rect]]];
}

// 通过镂空半透明浮层实现效果
- (void)showWithRectsToHollow:(NSArray <__kindof NSValue *>*)array
{
    [self addWindow];
    
    [self.rectArray removeAllObjects];
    [self.rectArray addObjectsFromArray:array];
    
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:self.guideWindow.bounds];
    for (NSValue *value in array) {
        
        CGRect rect = value.CGRectValue;
        // 抠出镂空区域
        [bpath appendPath:[[UIBezierPath bezierPathWithRect:rect] bezierPathByReversingPath]];
        
    }
    
    //创建一个CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    
    //添加图层蒙板
    self.backgoundView.layer.mask = shapeLayer;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapAction:)];
    [self.backgoundView addGestureRecognizer:tapGR];
}

- (void)addWindow
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.guideWindow = [[UIWindow alloc] initWithFrame:keyWindow.bounds];
    self.guideWindow.windowLevel = UIWindowLevelStatusBar + 1;
    self.guideWindow.rootViewController = self;
    
    [self.guideWindow makeKeyAndVisible];
    [self.guideWindow addSubview:self.view];
}

#pragma mark -
- (void)snapshotViewTapAction:(UITapGestureRecognizer *)sender
{
    if (self.tapBlock) {
        self.tapBlock(sender.view, sender.view.frame);
    }
}

- (void)backgroundTapAction:(UITapGestureRecognizer *)sender
{
    if (self.tapBlock) {
        for (NSValue *value in self.rectArray) {
            CGRect rect = value.CGRectValue;
            
            CGPoint touchPoint = [sender locationInView:self.backgoundView];
            
            if (CGRectContainsPoint(rect, touchPoint)) {
                self.tapBlock(nil, rect);
            }
        }
    }
}


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgoundView];
}

#pragma mark -
- (UIView *)backgoundView
{
    if (!_backgoundView) {
        _backgoundView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backgoundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _backgoundView.backgroundColor = [UIColor colorWithWhite:0 alpha:.8];
    }
    return _backgoundView;
}

- (NSMutableArray *)rectArray
{
    if (!_rectArray) {
        _rectArray = [NSMutableArray array];
    }
    return _rectArray;
}

- (NSMutableArray *)snapShotViewArray
{
    if (!_snapShotViewArray) {
        _snapShotViewArray = [NSMutableArray array];
    }
    return _snapShotViewArray;
}

- (NSMutableArray *)originalViewArray
{
    if (!_originalViewArray) {
        _originalViewArray = [NSMutableArray array];
    }
    return _originalViewArray;
}

@end
