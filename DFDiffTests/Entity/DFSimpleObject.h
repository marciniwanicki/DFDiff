//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFDiffId.h"

#ifndef DFMakeSimpleObject
#define DFMakeSimpleObject(key) [DFSimpleObject objectWithKey:key]
#endif

@interface DFSimpleObject : NSObject <DFDiffId>

- (instancetype)initWithKey:(NSString *)key;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToObject:(DFSimpleObject *)object;

- (NSUInteger)hash;

+ (instancetype)objectWithKey:(NSString *)key;

@end
