//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "URL.h"


@interface Scheme : URL
{
    NSString *mScheme;
}

- (id)initWithScheme:(NSString *)scheme andNext:(URL *)next;

- (NSString *)getStringContent;

- (void)store:(FinalURL *)storage;

- (void)format:(NSMutableString *)out;
@end