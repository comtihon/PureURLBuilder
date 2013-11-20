//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BaseParam.h"
#import "Param.h"

@class FinalURL;


@interface ArrayParam : BaseParam
{
    NSArray *mValues;
}
- (id)initWithValues:(NSArray *)values Key:(NSString *)key andNext:(URL *)next;

+ (BOOL)contains:(NSArray *)array andItem:(NSString *)value;

- (int)getValueHashCode;

- (void)store:(FinalURL *)storage;

- (void)storeInArray:(NSMutableArray *)out;

- (void)format:(NSMutableString *)out;

- (NSArray *)getValues;

- (BOOL)equalValues:(BaseParam *)param2;
@end