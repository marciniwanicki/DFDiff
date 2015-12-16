//
//  DFDiff.h
//  DFDiff
//
//  Created by Marcin Iwanicki on 13/12/2015.
//  Copyright © 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DFMove;
@class DFInsert;
@class DFDelete;

@interface DFDiff
<ObjectType> : NSObject

@property(nonatomic, readonly) NSArray <DFDelete *> *deletes;
@property(nonatomic, readonly) NSArray <DFInsert *> *inserts;
@property(nonatomic, readonly) NSArray <DFMove *> *moves;

- (instancetype)initWithSource:(ObjectType)source origin:(ObjectType)origin;

- (ObjectType)applyTo:(ObjectType)object;

@end
