//
//  NSObject+PreventKVC.h
//  TPreventKVC
//
//  Created by TBD on 2018/4/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KVCErrorType) {
    KVCErrorTypeSetValueForUndefinedKey     = 1,
    KVCErrorTypeValueForUndefinedKey        = 2,
    KVCErrorTypeSetNilValueForKey           = 3,
};

typedef void (^ __nullable HandleKVCErrorBlock)(Class cls,
                                                NSString *key,
                                                KVCErrorType errorType,
                                                NSArray<NSString *> * _Nonnull callStackSymbols);

@interface NSObject (PreventKVC)

+ (void)setHandleKVCErrorBlock:(HandleKVCErrorBlock)handleBlock;

@end
