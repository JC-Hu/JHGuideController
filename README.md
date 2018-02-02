# JHGuideController
易用的半透明浮层操作引导，只需给出需要高亮的view或rect区域，支持多个高亮区域。

Translucent guide window control.Just needs views or rects to highlight. 

## 效果图
![image](https://github.com/JC-Hu/JHGuideController/raw/master/GIF00.gif)

## 使用方法

```
// show
JHGuideController *guideController = [JHGuideController new];
guideController.snapshotViewUpdates = YES;
[guideController showWithViewsToSnapshot:@[view1, view2, view3]];

// callback
[guideController setTapBlock:^(UIView *snapshotView, CGRect rect) {
    // do something
}];
```

详见Demo工程
```
// 通过复制view实现效果
- (void)showWithViewToSnapshot:(UIView *)view;
- (void)showWithViewsToSnapshot:(NSArray<__kindof UIView *> *)array;


// 通过镂空半透明浮层实现效果
- (void)showWithRectToHollow:(CGRect)rect;
- (void)showWithRectsToHollow:(NSArray <__kindof NSValue *>*)array;
```