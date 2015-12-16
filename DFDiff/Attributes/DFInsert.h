//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DFInsert
<ObjectType> : NSObject

@property(nonatomic, readonly) NSInteger index;
@property(nonatomic, readonly) ObjectType value;

- (instancetype)initWithIndex:(NSInteger)index value:(id)value;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToInsert:(DFInsert *)insert;

- (NSUInteger)hash;

+ (instancetype)insertWithIndex:(NSInteger)index value:(id)value;

@end