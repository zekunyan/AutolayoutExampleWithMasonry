//
//  Case14Cell.m
//  MasonryExample
//
//  Created by tutuge on 2017/3/12.
//  Copyright © 2017年 tutuge. All rights reserved.
//

#import "Case14Cell.h"
#import <Masonry/Masonry.h>

@implementation Case14Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        
        _stairView = [Case14StairView new];
        _stairView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.1];
        [self.contentView addSubview:_stairView];
        
        [_stairView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(4, 4, 4, 4));
        }];
    }
    return self;
}

@end
