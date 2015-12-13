//
//  DFDiff.m
//  DFDiff
//
//  Created by Marcin Iwanicki on 13/12/2015.
//  Copyright © 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFDiff.h"
#import "DFMove.h"
#import "DFInsert.h"
#import "DFDelete.h"

@implementation DFDiff

- (instancetype)initWithSource:(id)source origin:(id)origin {
    @throw [NSException exceptionWithName:@"Cannot create instance of DFDiff class." reason:@"Not implemented" userInfo:nil];
}

- (id)applyTo:(id)object {
    @throw [NSException exceptionWithName:@"Cannot create instance of DFDiff class." reason:@"Not implemented" userInfo:nil];;
}

@end
