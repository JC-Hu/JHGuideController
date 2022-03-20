//
//  JHGuideController.h
//  Demo
//
//  Created by JasonHu on 2018/1/25.
//  Copyright © 2018年 JasonHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHGuideController : UIViewController

@property (nonatomic, strong) UIWindow *guideWindow;
@property (nonatomic, strong) UIView *backgoundView;

@property (nonatomic, copy) void (^tapBlock) (UIView *snapshotView, CGRect rect);

@property (nonatomic, assign) BOOL snapshotViewUpdates;

/// 镂空边距
@property (nonatomic, assign) UIEdgeInsets hollowInsets;
/// 镂空圆角
@property (nonatomic, assign) CGFloat hollowCornerRadius;

// 通过复制view实现效果
- (void)showWithViewToSnapshot:(UIView *)view;
- (void)showWithViewsToSnapshot:(NSArray<__kindof UIView *> *)array;

- (UIView *)snapShotViewForView:(UIView *)view;

// 通过镂空半透明浮层实现效果
- (void)showWithViewsToHollow:(NSArray<__kindof UIView *> *)array;
- (void)showWithRectToHollow:(CGRect)rect;
- (void)showWithRectsToHollow:(NSArray <__kindof NSValue *>*)array;

- (void)dismiss;

// 点击高亮区域回调
- (void)setTapBlock:(void (^)(UIView *snapshotView, CGRect rect))tapBlock;

@end
