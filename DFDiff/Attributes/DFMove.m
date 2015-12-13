//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFMove.h"

@interface DFMove ()

@property (nonatomic) NSInteger fromIndex;
@property (nonatomic) NSInteger toIndex;

@end

@implementation DFMove

- (instancetype)initWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self = [super init];
    if (self) {
        self.fromIndex = fromIndex;
        self.toIndex = toIndex;
    }

    return self;
}

+ (instancetype)moveWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    return [[self alloc] initWithFromIndex:fromIndex toIndex:toIndex];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToMove:other];
}

- (BOOL)isEqualToMove:(DFMove *)move {
    if (self == move)
        return YES;
    if (move == nil)
        return NO;
    if (self.fromIndex != move.fromIndex)
        return NO;
    if (self.toIndex != move.toIndex)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.fromIndex;
    hash = hash * 31u + self.toIndex;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.fromIndex=%li", (long)self.fromIndex];
    [description appendFormat:@", self.toIndex=%li", (long)self.toIndex];
    [description appendString:@">"];
    return description;
}

@end