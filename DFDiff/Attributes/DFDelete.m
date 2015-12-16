//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFDelete.h"

@interface DFDelete ()

@property(nonatomic) NSInteger index;

@end

@implementation DFDelete

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        self.index = index;
    }

    return self;
}

+ (instancetype)deleteWithIndex:(NSInteger)index {
    return [[self alloc] initWithIndex:index];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToDelete:other];
}

- (BOOL)isEqualToDelete:(DFDelete *)aDelete {
    if (self == aDelete)
        return YES;
    if (aDelete == nil)
        return NO;
    if (self.index != aDelete.index)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    return (NSUInteger) self.index;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.index=%li", (long) self.index];
    [description appendString:@">"];
    return description;
}

@end