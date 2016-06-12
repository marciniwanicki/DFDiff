//
// Created by Marcin Iwanicki on 19/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFArrayDiffDemoModelEntity.h"

@interface DFArrayDiffDemoModelEntity ()

@property (nonatomic, copy) NSString *value;

@end

@implementation DFArrayDiffDemoModelEntity

- (instancetype)initWithValue:(NSString *)value {
    self = [super init];
    if (self) {
        self.value = value;
    }

    return self;
}

+ (instancetype)entityWithValue:(NSString *)value {
    return [[self alloc] initWithValue:value];
}

- (NSString *)diffId {
    return self.value;
}

- (NSString *)description {
    return self.value;
}

@end
