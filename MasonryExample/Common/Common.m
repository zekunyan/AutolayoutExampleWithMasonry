//
// Created by zorro on 15/12/5.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import "Common.h"

@implementation Common

// 重复text字符串repeat次
+ (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *tmpText = [NSMutableString new];

    for (int i = 0; i < repeat; i++) {
        [tmpText appendString:text];
    }

    return tmpText;
}

@end