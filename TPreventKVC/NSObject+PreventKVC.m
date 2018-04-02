//
//  NSObject+PreventKVC.m
//  TPreventKVC
//
//  Created by TBD on 2018/4/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

#import "NSObject+PreventKVC.h"
#import <objc/runtime.h>

@implementation NSObject (PreventKVC)

#pragma mark - HandleUnrecognizedSELErrorBlock

+ (void)setHandleKVCErrorBlock:(HandleKVCErrorBlock)handleBlock {
    objc_setAssociatedObject(self, @selector(handleKVCErrorBlock), handleBlock, OBJC_ASSOCIATION_RETAIN);
}

+ (HandleKVCErrorBlock)handleKVCErrorBlock {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(setValue:forUndefinedKey:)),
                                       class_getInstanceMethod(self, @selector(__t_setValue:forUndefinedKey:)));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(valueForUndefinedKey:)),
                                       class_getInstanceMethod(self, @selector(__t_valueForUndefinedKey:)));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(setNilValueForKey:)),
                                       class_getInstanceMethod(self, @selector(__t_setNilValueForKey:)));
    });
}

- (void)__t_setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    HandleKVCErrorBlock handleBlock = [NSObject handleKVCErrorBlock];
    if (handleBlock != nil) {
        handleBlock([self class], key, KVCErrorTypeSetValueForUndefinedKey);
    }
}

- (nullable id)__t_valueForUndefinedKey:(NSString *)key {
    HandleKVCErrorBlock handleBlock = [NSObject handleKVCErrorBlock];
    if (handleBlock != nil) {
        handleBlock([self class], key, KVCErrorTypeValueForUndefinedKey);
    }
    return nil;
}

- (void)__t_setNilValueForKey:(NSString *)key {
    HandleKVCErrorBlock handleBlock = [NSObject handleKVCErrorBlock];
    if (handleBlock != nil) {
        handleBlock([self class], key, KVCErrorTypeSetNilValueForKey);
    }
    [self setValue:nil forKey:key];
}

@end
