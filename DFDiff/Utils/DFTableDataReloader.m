//
// Created by Marcin Iwanicki on 20/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFTableDataReloader.h"
#import "DFDiffId.h"
#import "DFArrayDiff.h"
#import "DFDelete.h"
#import "DFInsert.h"
#import "DFMove.h"


@interface DFTableDataReloader ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic) NSArray <id <DFDiffId>> *items;

@end

@implementation DFTableDataReloader

- (instancetype)initWithTableView:(__weak UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }

    return self;
}

+ (instancetype)reloaderWithTableView:(__weak UITableView *)tableView {
    return [[self alloc] initWithTableView:tableView];
}

- (void)reloadData:(NSArray <id <DFDiffId>> *)items {
    UITableView *tableView = self.tableView;
    if (!self.items) {
        self.items = items;
        [tableView reloadData];
    }

    DFArrayDiff *diff = [[DFArrayDiff alloc] initWithSource:items origin:self.items];
    [tableView beginUpdates];

    for (DFDelete *delete in diff.deletes) {
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(NSInteger) delete.index inSection:0]]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    for (DFInsert *insert in diff.inserts) {
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(NSInteger) insert.index inSection:0]]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    for (DFMove *move in diff.moves) {
        [tableView moveRowAtIndexPath:[NSIndexPath indexPathForItem:(NSInteger) move.fromIndex inSection:0]
                          toIndexPath:[NSIndexPath indexPathForRow:(NSInteger) move.toIndex inSection:0]];
    }

    [tableView endUpdates];
    self.items = items;
}

@end
