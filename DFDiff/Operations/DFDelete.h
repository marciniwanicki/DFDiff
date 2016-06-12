//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFDelete : NSObject

@property(nonatomic, readonly) NSUInteger index;

- (instancetype)initWithIndex:(NSUInteger)index;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToDelete:(DFDelete *)aDelete;

- (NSUInteger)hash;

+ (instancetype)deleteWithIndex:(NSUInteger)index;

@end
