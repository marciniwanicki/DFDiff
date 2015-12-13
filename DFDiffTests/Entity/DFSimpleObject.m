//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFSimpleObject.h"

@interface DFSimpleObject ()

@property (nonatomic, copy) NSString *key;

@end

@implementation DFSimpleObject

- (instancetype)initWithKey:(NSString *)key {
    self = [super init];
    if (self) {
        self.key = key;
    }

    return self;
}

+ (instancetype)objectWithKey:(NSString *)key {
    return [[self alloc] initWithKey:key];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToObject:other];
}

- (BOOL)isEqualToObject:(DFSimpleObject *)object {
    if (self == object)
        return YES;
    if (object == nil)
        return NO;
    if (self.key != object.key && ![self.key isEqualToString:object.key])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    return [self.key hash];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.key=%@", self.key];
    [description appendString:@">"];
    return description;
}

#pragma mark - DFDiffId

- (NSString *)diffId {
    return self.key;
}

@end