//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFArrayDiff.h"
#import "DFInsert.h"
#import "DFDelete.h"
#import "DFMove.h"

@interface DFArrayDiff ()

@property (nonatomic) NSArray <DFDelete *> *deletes;
@property (nonatomic) NSArray <DFInsert *> *inserts;
@property (nonatomic) NSArray <DFMove *> *moves;

@end

@implementation DFArrayDiff

@synthesize deletes = _deletes;
@synthesize inserts = _inserts;
@synthesize moves = _moves;

- (instancetype)initWithSource:(NSArray <id<DFDiffId>> *)source origin:(NSArray <id<DFDiffId>> *)origin {
    self = [self init];
    if (self) {
        [self prepareDiffForSource:source origin:origin];
    }
    return self;
}

- (NSArray <id<DFDiffId>> *)applyTo:(NSArray <id<DFDiffId>> *)array {
    NSUInteger newCount = array.count + self.inserts.count - self.deletes.count;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:newCount];
    for (NSInteger i = 0; i < newCount; ++i) {
        [result addObject:[NSNull null]];
    }

    // apply inserts elements
    for (DFInsert *insert in self.inserts) {
        result[insert.index] = insert.value;
    }

    // apply moves
    for (DFMove *move in self.moves) {
        result[move.toIndex] = array[move.fromIndex];
    }
    
    // copy the rest items from array but ignore deleted
    for (NSInteger i = 0; i < array.count; ++i) {
        BOOL diffIdDeleted = NO;
        
        for (NSInteger j = 0; j < self.deletes.count; ++j) {
            if (self.deletes[j].index == i) {
                diffIdDeleted = YES;
                break;
            }
        }
        
        if (diffIdDeleted) {
            continue;
        }
        
        BOOL diffIdAlreadyInserted = NO;
        NSString *diffId = [self diffId:i array:array];
        for (NSInteger j = 0; j < newCount; ++j) {
            if ([result[j] isEqual:[NSNull null]]) {
                continue;
            }
            
            NSString *existingDiffId = [self diffId:j array:result];
            if ([diffId isEqualToString:existingDiffId]) {
                diffIdAlreadyInserted = YES;
                break;
            }
        }
        
        if (diffIdAlreadyInserted) {
            continue;
        }
        
        for (NSInteger j = 0; j < newCount; ++j) {
            if ([result[j] isEqual:[NSNull null]]) {
                result[j] = array[i];
                break;
            }
        }
    }

    return result;
}


#pragma mark - Private

- (void)prepareDiffForSource:(NSArray <id <DFDiffId>> *)source origin:(NSArray <id<DFDiffId>> *)origin {
    [self prepareMovesAndDeletesForSource:source origin:origin];
    [self prepareInsertsForSource:source origin:origin];
    [self optimizeMoves];
}

- (void)prepareMovesAndDeletesForSource:(NSArray <id <DFDiffId>> *)source origin:(NSArray <id<DFDiffId>> *)origin {
    NSMutableArray *moves = [NSMutableArray array];
    NSMutableArray *deletes = [NSMutableArray array];

    for (NSInteger i = 0; i < origin.count; ++i) {
        NSString *originDiffId = [self diffId:i array:origin];
        BOOL diffIdDeleted = YES;

        for (NSInteger j = 0; j < source.count; ++j) {
            NSString *sourceDiffId = [self diffId:j array:source];

            if ([sourceDiffId isEqualToString:originDiffId]) {
                diffIdDeleted = NO;

                if (i != j) {
                    [moves addObject:[DFMove moveWithFromIndex:i toIndex:j]];
                }
            }
        }

        if (diffIdDeleted) {
            [deletes addObject:[DFDelete deleteWithIndex:i]];
        }
    }

    self.moves = moves;
    self.deletes = deletes;
}

- (void)prepareInsertsForSource:(NSArray <id <DFDiffId>> *)source origin:(NSArray <id<DFDiffId>> *)origin {
    NSMutableArray *inserts = [NSMutableArray array];

    for (NSInteger i = 0; i < source.count; ++i) {
        NSString *sourceDiffId = [self diffId:i array:source];
        BOOL diffIdInserted = YES;

        for (NSInteger j = 0; j < origin.count; ++j) {
            NSString *originDiffId = [self diffId:j array:origin];
            if ([sourceDiffId isEqualToString:originDiffId]) {
                diffIdInserted = NO;
                break;
            }
        }

        if (diffIdInserted) {
            [inserts addObject:[DFInsert insertWithIndex:i value:source[i]]];
        }
    }

    self.inserts = inserts;
}

- (void)optimizeMoves {
    NSMutableArray *moves = [self.moves mutableCopy];
    NSMutableArray *movesToDelete = [NSMutableArray array];

    for (NSInteger i = 0; i < self.moves.count; ++i) {
        DFMove *move = moves[i];

        NSInteger deleteInsertBalance = [self insertDeleteBalanceForIndex:move.fromIndex];

        if (move.toIndex - move.fromIndex == deleteInsertBalance) {
            [movesToDelete addObject:move];
        }
    }

    [moves removeObjectsInArray:movesToDelete];
    self.moves = moves;
}

- (NSString *)diffId:(NSInteger)index array:(NSArray <id<DFDiffId>> *)array {
    return array[index].diffId;
}

- (NSInteger)insertDeleteBalanceForIndex:(NSInteger)index {
    NSInteger deleteInsertBalance = 0;
    
    for (NSInteger j = 0; j <= index; ++j) {
        NSInteger sumOfInserts = 0;
        for (NSInteger k = 0; k < self.inserts.count; ++k) {
            if (self.inserts[k].index == j) {
                ++sumOfInserts;
            }
        }
        
        NSInteger sumOfDeletes = 0;
        for (NSInteger k = 0; k < self.deletes.count; ++k) {
            if (self.deletes[k].index == j) {
                ++sumOfDeletes;
            }
        }

        deleteInsertBalance += (sumOfInserts - sumOfDeletes);
    }
    
    return deleteInsertBalance;
}

@end