//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DFMove : NSObject

@property (nonatomic, readonly) NSInteger fromIndex;
@property (nonatomic, readonly) NSInteger toIndex;

- (instancetype)initWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToMove:(DFMove *)move;

- (NSUInteger)hash;

+ (instancetype)moveWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end