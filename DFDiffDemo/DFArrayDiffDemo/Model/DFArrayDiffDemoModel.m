//
// Created by Marcin Iwanicki on 19/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFArrayDiffDemoModel.h"
#import "DFArrayDiffDemoModelEntity.h"

@interface DFArrayDiffDemoModel ()

@property (nonatomic) NSArray <DFArrayDiffDemoModelEntity *> *predefinedValues;
@property (nonatomic) NSArray <DFArrayDiffDemoModelEntity *> *dataArray;

@end

@implementation DFArrayDiffDemoModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.predefinedValues = [self preparePredefinedValues];

        [self modifyDataArrayRandomly];
    }
    return self;
}

- (void)modifyDataArrayRandomly {
    self.dataArray = [self prepareDataArray];
    
    [self.delegate arrayDiffDemoModel:self didUpdateDataArray:self.dataArray];
}

- (void)modifyDataArrayByAddingOneRow {
    if (self.dataArray.count == self.predefinedValues.count) {
        return;
    }
    
    NSMutableArray *newDataArray = [self.dataArray mutableCopy];
    [newDataArray insertObject:[self randomEntityNotContainedInArray:self.dataArray] atIndex:[self randomIndexFromArray:newDataArray]];
    self.dataArray = newDataArray;

    [self.delegate arrayDiffDemoModel:self didUpdateDataArray:self.dataArray];
}

- (void)modifyDataArrayByRemovingOneRow {
    if (self.dataArray.count == 0) {
        return;
    }
    
    NSMutableArray *newDataArray = [self.dataArray mutableCopy];
    [newDataArray removeObjectAtIndex:[self randomIndexFromArray:newDataArray]];
    self.dataArray = newDataArray;

    [self.delegate arrayDiffDemoModel:self didUpdateDataArray:self.dataArray];
}

#pragma mark - Private

- (NSArray <DFArrayDiffDemoModelEntity *> *)preparePredefinedValues {
    NSMutableArray *values = [NSMutableArray new];
    for (NSInteger i = 0; i < 12; ++i) {
        NSString *value = [NSString stringWithFormat:@"%ld", (long)i];
        [values addObject:DFArrayDiffDemoModelEntityCreate(value)];
    }
    return values;
}

- (NSArray <DFArrayDiffDemoModelEntity *> *)prepareDataArray {
    NSMutableArray *dataArray = [NSMutableArray new];
    NSMutableArray *takenEntities = [NSMutableArray new];
    NSUInteger numberOfItems = MIN(6 + arc4random_uniform(4), self.predefinedValues.count);
    for (NSUInteger i = 0; i < numberOfItems; ++i) {
        DFArrayDiffDemoModelEntity *entity = [self randomEntityNotContainedInArray:takenEntities];
        [takenEntities addObject:entity];
        [dataArray addObject:entity];
    }
    return dataArray;
}

- (DFArrayDiffDemoModelEntity *)randomEntityNotContainedInArray:(NSArray *)array {
    NSUInteger index;
    do {
        index = [self randomIndexFromArray:self.predefinedValues];
    } while ([array containsObject:self.predefinedValues[index]]);
    return self.predefinedValues[index];
}

- (NSUInteger)randomIndexFromArray:(NSArray *)array {
    return arc4random_uniform((u_int32_t)array.count);
}

@end
