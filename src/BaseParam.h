//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "URL.h"


@interface BaseParam : URL
{
    NSString *mKey;
}


- (id)initWithKey:(NSString *)key next:(URL *)next;

- (NSString *)getKey;

- (unsigned int)hash;

- (BOOL)isEqual:(id)other;

- (BOOL)equalValues:(BaseParam *)param2;

- (int)getValueHashCode;

- (void)storeInArray:(NSMutableArray *)out;
@end