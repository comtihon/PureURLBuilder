//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BaseParam.h"

@class FinalURL;


@interface Param : BaseParam
{
    NSString *mValue;
}

- (id)initWithValue:(NSString *)value Key:(NSString *)key andNext:(URL*)next;

- (void)format:(NSMutableString *)out;

- (NSString *)getValue;

- (void)store:(FinalURL *)storage;

- (BOOL)equalValues:(BaseParam *)param2;

- (int)getValueHashCode;

- (void)storeInArray:(NSMutableArray *)out;
@end