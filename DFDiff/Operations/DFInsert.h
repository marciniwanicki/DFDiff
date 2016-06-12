//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DFInsert
<ObjectType> : NSObject

@property(nonatomic, readonly) NSUInteger index;
@property(nonatomic, readonly) ObjectType value;

- (instancetype)initWithIndex:(NSUInteger)index value:(id)value;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToInsert:(DFInsert *)insert;

- (NSUInteger)hash;

+ (instancetype)insertWithIndex:(NSUInteger)index value:(id)value;

@end
