//
// Created by Marcin Iwanicki on 19/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFDiffId.h"

#ifndef DFArrayDiffDemoModelEntityCreate
#define DFArrayDiffDemoModelEntityCreate(value) [DFArrayDiffDemoModelEntity entityWithValue:value]
#endif

@interface DFArrayDiffDemoModelEntity : NSObject <DFDiffId>

@property (nonatomic, copy, readonly) NSString *value;

- (instancetype)initWithValue:(NSString *)value;

- (NSString *)description;

+ (instancetype)entityWithValue:(NSString *)value;

@end
