//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "URL.h"
#import "BaseParam.h"

@interface FinalURL : NSObject
{
    URL *mScheme;
    URL *mHost;
    URL *mPort;
    URL *mPath;
    URL *mFragment;
    BOOL hasArrayParam;
    NSMutableSet *mStorage;
}

- (URL *)mScheme;

- (URL *)mHost;

- (URL *)mPort;

- (NSSet *)mStorage;

- (URL *)mPath;

- (URL *)mFragment;

- (void)setScheme:(URL *)protocol;

- (void)setHost:(URL *)host;

- (void)setPort:(URL *)port;

- (void)setPath:(URL *)path;

- (void)setFragment:(URL *)fragment;

- (void)setHasArrayParam:(BOOL)value;

- (void)addObject:(id)object;

- (void)build:(NSMutableString *)out;

- (NSString *)toString;

- (NSString *)getScheme;

- (int)getPort;

- (NSString *)getPath;

- (NSString *)getFragment;

- (NSArray *)getParamsList;

- (BOOL)isEqual:(id)other;

- (NSUInteger)hash;

- (id)init;

@end