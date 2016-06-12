//
// Created by Marcin Iwanicki on 19/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DFArrayDiffDemoModel;
@protocol DFDiffId;
@class DFArrayDiffDemoModelEntity;

@protocol DFArrayDiffDemoModelDelegate

- (void)arrayDiffDemoModel:(DFArrayDiffDemoModel *)model didUpdateDataArray:(NSArray <DFArrayDiffDemoModelEntity *> *)dataArray;

@end

@interface DFArrayDiffDemoModel : NSObject

@property (nonatomic, weak) id <DFArrayDiffDemoModelDelegate> delegate;
@property (nonatomic, readonly) NSArray <DFArrayDiffDemoModelEntity *> *dataArray;

- (void)modifyDataArrayRandomly;

- (void)modifyDataArrayByAddingOneRow;

- (void)modifyDataArrayByRemovingOneRow;

@end
