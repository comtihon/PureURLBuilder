//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "URL.h"

@class FinalURL;


@interface Fragment : URL
{
    NSString *mFragment;
}
- (id)initWithFragment:(NSString *)fragment andNext:(URL *)next;

- (void)store:(FinalURL *)storage;

- (void)format:(NSMutableString *)out;

- (NSString *)getStringContent;
@end