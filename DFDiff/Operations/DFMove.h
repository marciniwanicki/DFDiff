//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DFMove : NSObject

@property(nonatomic, readonly) NSUInteger fromIndex;
@property(nonatomic, readonly) NSUInteger toIndex;

- (instancetype)initWithFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (NSInteger)delta;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToMove:(DFMove *)move;

- (NSUInteger)hash;

+ (instancetype)moveWithFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
