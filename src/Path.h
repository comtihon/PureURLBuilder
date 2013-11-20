//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "URL.h"

@class FinalURL;


@interface Path : URL
{
    NSString *mName;
}
- (id)initWithName:(NSString *)name andNext:(URL *)next;

- (void)format:(NSMutableString *)out;

- (void)store:(FinalURL *)storage;

- (NSString *)getStringContent;
@end