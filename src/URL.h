//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>

@class FinalURL;

@interface URL : NSObject
{
    URL *mNext;
}

@property (nonatomic, readonly) URL *(^withHost)(NSString *name);
@property (nonatomic, readonly) URL *(^withPath)(NSString *name);
@property (nonatomic, readonly) URL *(^withArrayPath)(NSArray *value);
@property (nonatomic, readonly) URL *(^withPort)(int port);
@property (nonatomic, readonly) URL *(^withScheme)(NSString *scheme);
@property (nonatomic, readonly) URL *(^withFragment)(NSString *fragment);
@property (nonatomic, readonly) URL *(^withIntParam)(NSString *name, int value);
@property (nonatomic, readonly) URL *(^withLongParam)(NSString *name, long value);
@property (nonatomic, readonly) URL *(^withBoolParam)(NSString *name, BOOL value);
@property (nonatomic, readonly) URL *(^withStringParam)(NSString *name, NSString *value);
@property (nonatomic, readonly) URL *(^withCharParam)(NSString *name, char *value);
@property (nonatomic, readonly) URL *(^withArrayParam)(NSString *name, NSArray *value);
@property (nonatomic, readonly) URL *(^withDictParam)(NSDictionary *value);

+ (URL *)http;

+ (URL *)https;

+ (URL *)empty;

- (id)initWithNext:(URL *)next;

- (NSString *)toString;

- (FinalURL *)toFinalUrl;

- (void)build:(NSMutableString *)out;

+ (URL *)parse:(NSString *)src;

+ (URL *)parseQuery:(URL *)result andQuery:(NSString *)query;

- (NSString *)urlEncode:(NSString *)original;

- (void)store:(FinalURL *)storage;

- (void)format:(NSMutableString *)out;

- (NSString *)getStringContent;

- (int)getIntContent;

@end