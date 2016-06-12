//
// Created by Marcin Iwanicki on 20/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DFDiffId;

@interface DFTableDataReloader : NSObject

- (instancetype)initWithTableView:(__weak UITableView *)tableView;

+ (instancetype)reloaderWithTableView:(__weak UITableView *)tableView;

- (void)reloadData:(NSArray <id <DFDiffId>> *)items;

@end
