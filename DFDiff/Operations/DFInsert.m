//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFInsert.h"

@interface DFInsert ()

@property(nonatomic) NSUInteger index;
@property(nonatomic) id value;

@end

@implementation DFInsert

- (instancetype)initWithIndex:(NSUInteger)index value:(id)value {
    self = [super init];
    if (self) {
        self.index = index;
        self.value = value;
    }

    return self;
}

+ (instancetype)insertWithIndex:(NSUInteger)index value:(id)value {
    return [[self alloc] initWithIndex:index value:value];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToInsert:other];
}

- (BOOL)isEqualToInsert:(DFInsert *)insert {
    if (self == insert)
        return YES;
    if (insert == nil)
        return NO;
    if (self.index != insert.index)
        return NO;
    if (self.value != insert.value && ![self.value isEqual:insert.value])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = self.index;
    hash = hash * 31u + [self.value hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.index=%li", (long) self.index];
    [description appendFormat:@", self.value=%@", self.value];
    [description appendString:@">"];
    return description;
}

@end
