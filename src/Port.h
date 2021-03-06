//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "URL.h"
#import "FinalURL.h"


@interface Port : URL
{
    int mPort;
}

- (id)initWithPort:(int)port andNext:(URL *)next;

- (void)store:(FinalURL *)storage;

- (void)format:(NSMutableString *)out;

- (int)getIntContent;
@end