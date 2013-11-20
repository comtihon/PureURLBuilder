//
// Created by Valery Tikhonov on 11/14/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface StringTokenizer : NSObject
{
    BOOL mOrder;
    NSString *mString;
    NSString *mDelimeters;
}
- (id)initWithString:(NSString *)string andDelimeters:(NSString *)delimeters andOrder:(BOOL)returnDel;

- (NSArray *)split;
@end