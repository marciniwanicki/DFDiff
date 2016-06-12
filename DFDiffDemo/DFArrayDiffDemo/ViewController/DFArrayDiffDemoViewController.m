//
// Created by Marcin Iwanicki on 19/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFArrayDiffDemoViewController.h"
#import "DFArrayDiffDemoModel.h"
#import "DFDiffId.h"
#import "DFArrayDiffDemoModelEntity.h"
#import "DFTableDataReloader.h"

@interface DFArrayDiffDemoViewController () <DFArrayDiffDemoModelDelegate>

@property (nonatomic) DFArrayDiffDemoModel *arrayDiffDemoModel;
@property (nonatomic) DFTableDataReloader *tableDataReloader;

@end

@implementation DFArrayDiffDemoViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayDiffDemoModel = [DFArrayDiffDemoModel new];
    self.arrayDiffDemoModel.delegate = self;

    self.tableDataReloader = [DFTableDataReloader reloaderWithTableView:self.tableView];
}

#pragma mark - IBActions

- (IBAction)didTouchModifyButton:(id)sender {
    [self.arrayDiffDemoModel modifyDataArrayRandomly];
}

- (IBAction)didTouchInsertButton:(id)sender {
    [self.arrayDiffDemoModel modifyDataArrayByAddingOneRow];
}

- (IBAction)didTouchDeleteButton:(id)sender {
    [self.arrayDiffDemoModel modifyDataArrayByRemovingOneRow];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger) self.arrayDiffDemoModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ArrayDiffCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell.textLabel setText:self.arrayDiffDemoModel.dataArray[(NSUInteger) indexPath.row].value];
    return cell;
}

#pragma mark - DFArrayDiffDemoModelDelegate

- (void)arrayDiffDemoModel:(DFArrayDiffDemoModel *)model didUpdateDataArray:(NSArray <DFArrayDiffDemoModelEntity *> *)dataArray {
    [self.tableDataReloader reloadData:dataArray];
}

@end
