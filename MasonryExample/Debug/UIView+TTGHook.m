//
// Created by zorro on 15/12/28.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+TTGHook.h"

//#define HOOK_ON 1

@implementation UIView (TTGHook)

#ifdef HOOK_ON

+ (void)load {
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(my_dealloc));
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)my_dealloc {
    NSLog(@"<HOOK> %@ with tag: %ld dealloc.", [self class], (long) self.tag);
    [self my_dealloc];
}

#endif

@end