//
//  Case14StairView.m
//  MasonryExample
//
//  Created by tutuge on 2016/11/7.
//  Copyright © 2016年 tutuge. All rights reserved.
//

#import "Case14StairView.h"

@interface Case14StairView ()
@property (nonatomic, strong) NSMutableArray <UILabel *> *itemViews;
@property (nonatomic, assign) CGSize contentSize;
@end

@implementation Case14StairView

- (void)setStairTitles:(NSArray<NSString *> *)titles {
    // 从superView删除
    [_itemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 重新创建
    _itemViews = [NSMutableArray new];
    
    // 循环创建新的Label
    for (NSString *title in titles) {
        UILabel *label = [UILabel new];
        label.text = title;
        label.font = [UIFont systemFontOfSize:12];
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        label.layer.borderWidth = 1.0f / [UIScreen mainScreen].scale;
        label.numberOfLines = 0;
        [self addSubview:label];
        [_itemViews addObject:label];
    }
    
    // 重新布局
    _contentSize = CGSizeZero;
    [self updateStairLayout];
}

- (CGSize)intrinsicContentSize {
    [self updateStairLayout];
    return _contentSize;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateStairLayout];
}

- (void)updateStairLayout {
    if (_itemViews.count == 0) {
        return;
    }
    
    // 平均宽度
    CGFloat eachLabelWidth = CGRectGetWidth(self.bounds) / (CGFloat)_itemViews.count;
    CGFloat lastY = 0;
    CGFloat lastX = 0;
    
    for (UILabel *label in _itemViews) {
        // 计算高度
        label.preferredMaxLayoutWidth = eachLabelWidth;
        CGFloat height = [label sizeThatFits:CGSizeMake(eachLabelWidth, 0)].height;
        
        // 设置frame
        CGRect frame = CGRectMake(lastX, lastY, eachLabelWidth, height);
        label.frame = frame;
        
        // 更新下一轮
        lastX += eachLabelWidth;
        lastY += height;
    }
    
    // 更新contentSize
    _contentSize = CGSizeMake(CGRectGetWidth(self.bounds), lastY);
    
    // 通知外部IntrinsicContentSize失效
    [self invalidateIntrinsicContentSize];
}

@end
