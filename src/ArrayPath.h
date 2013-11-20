//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "URL.h"

@class FinalURL;


@interface ArrayPath : URL
{
    NSArray *mParts;
}

- (id)initWithParts:(NSArray *)parts andNext:(URL *)next;

- (void)store:(FinalURL *)storage;

- (NSString *)getStringContent;

- (void)format:(NSMutableString *)out;
@end