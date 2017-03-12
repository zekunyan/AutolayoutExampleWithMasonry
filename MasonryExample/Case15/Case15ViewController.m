//
//  Case15ViewController.m
//  MasonryExample
//
//  Created by tutuge on 2017/3/13.
//  Copyright © 2017年 tutuge. All rights reserved.
//

#import "Case15ViewController.h"
#import "Common.h"
#import <Masonry/Masonry.h>

@interface Case15ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *leftLabels;

@property (nonatomic, strong) UILabel *greenLabel;
@end

@implementation Case15ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _greenLabel = [UILabel new];
    _greenLabel.backgroundColor = [UIColor greenColor];
    _greenLabel.text = @"Green Label";
    [_containerView addSubview:_greenLabel];
    
    // 内容优先显示
    [_greenLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 垂直居中
        make.centerY.equalTo(_containerView);
        
        // 右边不超出
        make.right.lessThanOrEqualTo(_containerView);
        
        // 左边大于等于父View宽度的1/3，注意不是width属性
        make.left.greaterThanOrEqualTo(_containerView.mas_right).multipliedBy((CGFloat)(1.0f / 3.0f));
        
        // 左边大于所有左边label的右边+8
        for (UILabel *label in _leftLabels) {
            make.left.greaterThanOrEqualTo(label.mas_right).offset(8);
        }
    }];
}

#pragma mark - Action

- (IBAction)onTapStepper:(UIStepper *)sender {
    UILabel *label = _leftLabels[sender.tag];
    label.text = [Common getText:@"label" withRepeat:(int)sender.value];
}

@end
