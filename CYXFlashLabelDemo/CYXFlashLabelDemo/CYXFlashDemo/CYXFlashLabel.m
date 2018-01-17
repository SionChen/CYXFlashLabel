//
//  CYXFlashLabel.m
//  CYXFlashLabelDemo
//
//  Created by 超级腕电商 on 2018/1/17.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "CYXFlashLabel.h"
@interface CYXFlashLabel()

@property (nonatomic,strong) UIView *innerContainer;
/*滚动速率*/
@property (nonatomic,assign) CGFloat speedRate;
@end
@implementation CYXFlashLabel{
    BOOL moveNeed;//是否需要滚动
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor blackColor];
        self.speed = CYXFlashSpeedMild;
        self.repeatCount = 0;
        self.leastInnerGap = 10.f;
        self.clipsToBounds = YES;
        self.innerContainer = [[UIView alloc] initWithFrame:self.bounds];
        self.innerContainer.backgroundColor = [UIColor clearColor];
        self.innerContainer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.innerContainer];
    }
    return self;
}

- (void)reloadView
{
    [self removeViewAndLayer];
    
    CGFloat width = [self evaluateContentWidth];
    moveNeed = width > self.bounds.size.width;
    CGRect f = CGRectMake(0, 0, width, self.bounds.size.height);
    UILabel *label = [[UILabel alloc] initWithFrame:f];
    label.backgroundColor = [UIColor clearColor];
    if (self.text) {
        label.text = self.text;
        label.textColor = self.textColor;
        label.font = self.font;
    } else {
        label.attributedText = self.attributedText;
    }
    
    [self.innerContainer addSubview:label];
    if (moveNeed) {
        CGRect f1 = CGRectMake(width + self.leastInnerGap, 0, width, f.size.height);
        UILabel *next = [[UILabel alloc] initWithFrame:f1];
        next.backgroundColor = [UIColor clearColor];
        if (self.text) {
            next.text = self.text;
            next.textColor = self.textColor;
            next.font = self.font;
        } else {
            next.attributedText = self.attributedText;
        }
        
        [self.innerContainer addSubview:next];
        
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        //moveAnimation.keyTimes = @[@0., @0.191, @0.868, @1.0];
        moveAnimation.keyTimes = @[@0., @1.0];
        moveAnimation.duration = width / self.speedRate;
        //moveAnimation.values = @[@0, @0., @(- width - self.leastInnerGap)];
        moveAnimation.values = @[@0,@(- width - self.leastInnerGap)];
        moveAnimation.repeatCount = self.repeatCount == 0 ? INT16_MAX : self.repeatCount;
        moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        [self.innerContainer.layer addAnimation:moveAnimation forKey:@"move"];
    }
}

/**
 移除相关视图
 */
-(void)removeViewAndLayer{
    [self.innerContainer.layer removeAnimationForKey:@"move"];
    for (UIView *sub in self.innerContainer.subviews) {
        if ([sub isKindOfClass:[UILabel class]]) {
            [sub removeFromSuperview];
        }
    }
}
/**
 计算总的宽度

 @return -
 */
- (CGFloat)evaluateContentWidth
{
    CGFloat width = 0.f;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    if (_text.length > 0) {
        NSDictionary *attr = @{NSFontAttributeName : self.font};
        CGSize size = [_text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:options attributes:attr context:nil].size;
        width = size.width;
        
    } else if (_attributedText.length > 0) {
        CGSize size = [_attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:options context:nil].size;
        width = size.width;
    }
    
    return width;
}
#pragma mark ---Set
- (void)setSpeed:(CYXFlashSpeed)speed
{
    _speed = speed;
    switch (_speed) {
        case CYXFlashSpeedFast:
            self.speedRate = 90.;
            break;
        case CYXFlashSpeedMild:
            self.speedRate = 75;
            break;
        case CYXFlashSpeedSlow:
            self.speedRate = 40.;
            break;
        default:
            break;
    }
    [self reloadView];
}

- (void)setLeastInnerGap:(CGFloat)leastInnerGap
{
    _leastInnerGap = leastInnerGap;
    [self reloadView];
}

- (void)setText:(NSString *)text
{
    _text = text;
    _attributedText = nil;
    [self reloadView];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = [self setAttributedTextDefaultFont:attributedText];
    _text = nil;
    [self reloadView];
}

- (NSAttributedString *)setAttributedTextDefaultFont:(NSAttributedString *)attrText
{
    NSMutableAttributedString *rtn = [[NSMutableAttributedString alloc] initWithAttributedString:attrText];
    void (^enumerateBlock)(id, NSRange, BOOL *) = ^(id value, NSRange range, BOOL *stop) {
        if (!value || [value isKindOfClass:[NSNull class]]) {
            
            [rtn addAttribute:NSFontAttributeName
                        value:self.font
                        range:range];
        }
    };
    [rtn enumerateAttribute:NSFontAttributeName
                    inRange:NSMakeRange(0, rtn.string.length)
                    options:0
                 usingBlock:enumerateBlock];
    return rtn;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self reloadView];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self reloadView];
}
@end
