//
//  ViewController.m
//  Demo
//
//  Created by JasonHu on 2018/1/25.
//  Copyright © 2018年 JasonHu. All rights reserved.
//

#import "ViewController.h"

#import "JHGuideController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *testButton;

@property (weak, nonatomic) IBOutlet UIButton *testButton2;

@property (weak, nonatomic) IBOutlet UIButton *testButton3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self showGuide];
    });
}

- (IBAction)testButtonAction:(id)sender {
    
    [self showGuide];
}

- (void)showGuide
{
    // show
    JHGuideController *guideController = [JHGuideController new];
    guideController.snapshotViewUpdates = YES;
    
    //    [guideController showWithViewToSnapshot:self.testButton];
    //        [guideController showWithRectToHollow:self.testButton.frame];
    
    [guideController showWithViewsToSnapshot:@[self.testButton, self.testButton2, self.testButton3]];
    
    //    [guideController showWithRectsToHollow:@[[self handleTargetView:self.testButton guideVC:guideController],[self handleTargetView:self.testButton2 guideVC:guideController],[self handleTargetView:self.testButton3 guideVC:guideController]]];
    
    // callback
    __weak JHGuideController *weakGuideController = guideController;
    [guideController setTapBlock:^(UIView *snapshotView, CGRect rect) {
        [weakGuideController dismiss];
    }];
    
    // customize
    UIView *snapView = [guideController snapShotViewForView:self.testButton];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(snapView.frame) + 6, CGRectGetMinY(snapView.frame), 0, 0)];
    hintLabel.numberOfLines = 0;
    hintLabel.text = @"← Tap here to dismiss";
    hintLabel.textColor = [UIColor colorWithWhite:.8 alpha:1];
    [hintLabel sizeToFit];
    [guideController.view addSubview:hintLabel];
    
}

- (NSValue *)handleTargetView:(UIView *)view guideVC:(JHGuideController *)guideVC
{
    
    CGRect rect = [view convertRect:view.bounds toView:view.window];
        
    return [NSValue valueWithCGRect:rect];
}




@end
