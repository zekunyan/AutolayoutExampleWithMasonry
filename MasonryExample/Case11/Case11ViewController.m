//
//  Case11ViewController.m
//  MasonryExample
//
//  Created by tutuge on 16/8/6.
//  Copyright © 2016年 tutuge. All rights reserved.
//

#import "Case11ViewController.h"
#import <Masonry/Masonry.h>

@interface Case11ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) MASConstraint *leftConstraint;
@property (nonatomic, strong) MASConstraint *topConstraint;
@end

@implementation Case11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _containerView.layer.masksToBounds = YES;
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.borderColor = [UIColor redColor].CGColor;
    
    self.tipLabel.text = @"tutuge";
    [_containerView addSubview:self.tipLabel];
    [_tipLabel sizeToFit];
    
    // 设置主Label的约束
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置边界条件约束，保证内容可见，优先级1000
        make.left.greaterThanOrEqualTo(_containerView.mas_left);
        make.right.lessThanOrEqualTo(_containerView.mas_right);
        make.top.greaterThanOrEqualTo(_containerView.mas_top);
        make.bottom.lessThanOrEqualTo(_containerView.mas_bottom);
        
        _leftConstraint = make.centerX.equalTo(_containerView.mas_left).with.offset(50).priorityHigh(); // 优先级要比边界条件低
        _topConstraint = make.centerY.equalTo(_containerView.mas_top).with.offset(50).priorityHigh(); // 优先级要比边界条件低
        make.width.mas_equalTo(CGRectGetWidth(_tipLabel.frame) + 8);
        make.height.mas_equalTo(CGRectGetHeight(_tipLabel.frame) + 4);
    }];
    
    // Attachment，依附在tipLabel右上方
    UIView *attachmentView = [self generateNewAttachmentLabelWithContent:@" Attachemnt "];
    [_containerView addSubview:attachmentView];
    
    [attachmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 依附在tipLabel上
        make.left.equalTo(_tipLabel.mas_left).with.offset(20).priorityHigh();
        make.bottom.equalTo(_tipLabel.mas_top).with.offset(-2).priorityHigh();
        
        // 边界条件
        make.top.greaterThanOrEqualTo(_containerView.mas_top);
        make.right.lessThanOrEqualTo(_containerView.mas_right);
    }];
    
    // 拖动Gesture
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panWithGesture:)];
    [_containerView addGestureRecognizer:pan];
}

#pragma mark - Pan gesture

- (void)panWithGesture:(UIPanGestureRecognizer *)pan {
    CGPoint touchPoint = [pan locationInView:_containerView];
    
    _logLabel.text = NSStringFromCGPoint(touchPoint);
    
    _leftConstraint.offset = touchPoint.x;
    _topConstraint.offset = touchPoint.y;
}

#pragma mark - Getter

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.numberOfLines = 2;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.backgroundColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1];
        _tipLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _tipLabel.layer.borderWidth = 1.0f;
        _tipLabel.layer.masksToBounds = YES;
        _tipLabel.layer.cornerRadius = 2.0f;
    }
    return _tipLabel;
}

- (UILabel *)generateNewAttachmentLabelWithContent:(NSString *)content {
    UILabel *label = [UILabel new];
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 2.0f;
    
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    label.text = content;
    [label sizeToFit];
    
    return label;
}

@end
