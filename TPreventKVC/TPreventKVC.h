//
//  TPreventKVC.h
//  TPreventKVC
//
//  Created by TBD on 2018/4/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<TPreventKVC/TPreventKVC.h>)
FOUNDATION_EXPORT double TPreventKVCVersionNumber;
FOUNDATION_EXPORT const unsigned char TPreventKVCVersionString[];
#import <TPreventKVC/NSObject+PreventKVC.h>
#else
#import "TPreventKVC/NSObject+PreventKVC.h"
#endif
