//
//  main.m
//  TPreventKVC Example
//
//  Created by TBD on 2018/4/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TPreventKVC/TPreventKVC.h>

@interface TestPreventKVC: NSObject

@end

@implementation TestPreventKVC

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Begin Test Prevent KVC");
        [NSObject setHandleKVCErrorBlock:^(__unsafe_unretained Class cls, NSString *key, KVCErrorType errorType) {
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
        }];
        
        TestPreventKVC *obj = [[TestPreventKVC alloc] init];
        [obj setValue:@"value" forKey:@"_undefinedKey_1"];
        [obj valueForKey:@"_undefinedKey_2"];
        NSLog(@"Test Prevent KVC Success");
    }
    return 0;
}