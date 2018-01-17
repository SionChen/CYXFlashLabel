//
//  ViewController.m
//  CYXFlashLabelDemo
//
//  Created by 超级腕电商 on 2018/1/17.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "ViewController.h"
#import "CYXFlashLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CYXFlashLabel * label = [[CYXFlashLabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    label.backgroundColor = [UIColor yellowColor];
    label.leastInnerGap = 50.f;
    label.speed = CYXFlashSpeedMild;
    NSString *str = @"我是跑马灯文字是的撒的撒的222111到底是多少嗯嗯嗯方法vss22电放费";
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
    [att addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:25]
                range:NSMakeRange(0, 5)];
    [att addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:17]
                range:NSMakeRange(15, 5)];
    [att addAttribute:NSBackgroundColorAttributeName
                value:[UIColor cyanColor]
                range:NSMakeRange(0, 15)];
    [att addAttribute:NSForegroundColorAttributeName
                value:[UIColor redColor]
                range:NSMakeRange(8, 7)];
    label.attributedText = att;
    [self.view addSubview:label];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
