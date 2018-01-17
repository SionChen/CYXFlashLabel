//
//  CYXFlashLabel.h
//  CYXFlashLabelDemo
//
//  Created by 超级腕电商 on 2018/1/17.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CYXFlashSpeed) {
    CYXFlashSpeedSlow = -1,
    CYXFlashSpeedMild,
    CYXFlashSpeedFast
};

@interface CYXFlashLabel : UIView
#pragma mark ---模仿label属性
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;         // 默认:system(15)
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSAttributedString *attributedText;
#pragma mark ---跑马灯效果特有属性
/*跑马速度*/
@property (nonatomic, assign) CYXFlashSpeed speed;
/*循环滚动次数(为0时无限滚动)*/
@property (nonatomic, assign) NSUInteger repeatCount;
/*循环文字与下一次循环文字的间隙*/
@property (nonatomic, assign) CGFloat leastInnerGap;

- (void)reloadView;

@end
