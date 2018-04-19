//
//  main.m
//  TPreventKVC Example
//
//  Created by TBD on 2018/4/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TPreventKVC/TPreventKVC.h>

@interface TestPreventKVCTestObj : NSObject

@end

@implementation TestPreventKVCTestObj

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Begin Test Prevent KVC");
        [NSObject setHandleKVCErrorBlock:^(__unsafe_unretained Class cls, NSString *key, KVCErrorType errorType, NSArray<NSString *> * _Nonnull callStackSymbols) {
            NSString *errorTypeStr;
            switch (errorType) {
                case KVCErrorTypeSetNilValueForKey:
                    errorTypeStr = @"SetNilValueForKey";
                    break;
                    
                case KVCErrorTypeValueForUndefinedKey:
                    errorTypeStr = @"ValueForUndefinedKey";
                    break;
                    
                case KVCErrorTypeSetValueForUndefinedKey:
                    errorTypeStr = @"SetValueForUndefinedKey";
                    break;
                default:
                    break;
            }
            NSLog(@">> %@ <<, %@ for key: %@", NSStringFromClass(cls), errorTypeStr, key);
            NSLog(@"%@", callStackSymbols);
        }];
        
        TestPreventKVCTestObj *obj = [[TestPreventKVCTestObj alloc] init];
        [obj setValue:@"value" forKey:@"_undefinedKey1"];
        [obj valueForKey:@"_undefinedKey2"];
        [obj setValue:@"value" forKeyPath:@"undefinedKeyPath1.path"];
        [obj valueForKeyPath:@"undefinedKeyPath2.path"];
        NSLog(@"Test Prevent KVC Success");
    }
    return 0;
}
