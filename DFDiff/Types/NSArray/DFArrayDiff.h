//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFDiff.h"
#import "DFDiffId.h"

@interface DFArrayDiff <ObjectType> : DFDiff <NSArray<ObjectType <DFDiffId>> *>

- (instancetype)initWithSource:(NSArray<ObjectType <DFDiffId>> *)source origin:(NSArray<ObjectType <DFDiffId>> *)origin;

- (NSArray<ObjectType <DFDiffId>> *)applyTo:(NSArray<ObjectType <DFDiffId>> *)object;

@end