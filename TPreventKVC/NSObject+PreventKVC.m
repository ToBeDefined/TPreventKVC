//
//  NSObject+PreventKVC.m
//  TPreventKVC
//
//  Created by TBD on 2018/4/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

#import "NSObject+PreventKVC.h"
#import <objc/runtime.h>


#pragma mark - Safe Exchange Method
#pragma mark -

static inline
void __tp_kvc_exchange_instance_method(Class cls, SEL originalSel, SEL swizzledSel) {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
    
    // 交换实现进行添加函数
    BOOL addOriginSELSuccess = class_addMethod(cls,
                                               originalSel,
                                               method_getImplementation(swizzledMethod),
                                               method_getTypeEncoding(swizzledMethod));
    BOOL addSwizzlSELSuccess = class_addMethod(cls,
                                               swizzledSel,
                                               method_getImplementation(originalMethod),
                                               method_getTypeEncoding(originalMethod));
    // 全都添加成功，返回
    if (addOriginSELSuccess && addSwizzlSELSuccess) {
        return;
    }
    // 全都添加失败，已经添加过了方法，交换
    if (!addOriginSELSuccess && !addSwizzlSELSuccess) {
        method_exchangeImplementations(originalMethod,
                                       swizzledMethod);
        return;
    }
    // addOriginSELSuccess 成功，addSwizzlSELSuccess 失败，replace SwizzlSel
    if (addOriginSELSuccess && !addSwizzlSELSuccess) {
        class_replaceMethod(cls,
                            swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        return;
    }
    // addSwizzlSELSuccess 成功，addOriginSELSuccess 失败，replace originSEL
    if (!addOriginSELSuccess && addSwizzlSELSuccess) {
        class_replaceMethod(cls,
                            originalSel,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
        return;
    }
}


#pragma mark - Implementation Replace
#pragma mark -

@implementation NSObject (PreventKVC)

#pragma mark - HandleKVCErrorBlock

+ (void)setHandleKVCErrorBlock:(HandleKVCErrorBlock)handleBlock {
    objc_setAssociatedObject(self, @selector(handleKVCErrorBlock), handleBlock, OBJC_ASSOCIATION_RETAIN);
}

+ (HandleKVCErrorBlock)handleKVCErrorBlock {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - Implementation
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __tp_kvc_exchange_instance_method(self,
                                          @selector(setValue:forUndefinedKey:),
                                          @selector(__t_setValue:forUndefinedKey:));
        __tp_kvc_exchange_instance_method(self,
                                          @selector(valueForUndefinedKey:),
                                          @selector(__t_valueForUndefinedKey:));
        __tp_kvc_exchange_instance_method(self,
                                          @selector(setNilValueForKey:),
                                          @selector(__t_setNilValueForKey:));
    });
}

- (void)__t_setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    HandleKVCErrorBlock handleBlock = [NSObject handleKVCErrorBlock];
    if (handleBlock != nil) {
        NSArray <NSString *>*callStackSymbols = @[@"The system version is too low."];
        if (@available(iOS 4.0, tvOS 9.0, macOS 10.6, watchOS 2.0, *)) {
            callStackSymbols = [NSThread callStackSymbols];
        }

        handleBlock([self class], key, KVCErrorTypeSetValueForUndefinedKey, callStackSymbols);
    }
}

- (nullable id)__t_valueForUndefinedKey:(NSString *)key {
    HandleKVCErrorBlock handleBlock = [NSObject handleKVCErrorBlock];
    if (handleBlock != nil) {
        NSArray <NSString *>*callStackSymbols = @[@"The system version is too low."];
        if (@available(iOS 4.0, tvOS 9.0, macOS 10.6, watchOS 2.0, *)) {
            callStackSymbols = [NSThread callStackSymbols];
        }

        handleBlock([self class], key, KVCErrorTypeValueForUndefinedKey, callStackSymbols);
    }
    return nil;
}

- (void)__t_setNilValueForKey:(NSString *)key {
    HandleKVCErrorBlock handleBlock = [NSObject handleKVCErrorBlock];
    if (handleBlock != nil) {
        NSArray <NSString *>*callStackSymbols = @[@"The system version is too low."];
        if (@available(iOS 4.0, tvOS 9.0, macOS 10.6, watchOS 2.0, *)) {
            callStackSymbols = [NSThread callStackSymbols];
        }

        handleBlock([self class], key, KVCErrorTypeSetNilValueForKey, callStackSymbols);
    }
    [self setValue:nil forKey:key];
}

@end
