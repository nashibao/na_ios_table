//
//  NAArrayTableViewController.h
//  SK3
//
//  Created by nashibao on 2012/10/12.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import "NATableViewController.h"

#import "NAFormValue.h"

/*
 辞書形式でデータを描画できるタイプのtable.
 Form用のTableViewで使用．
 */
@interface NAArrayTableViewController : NATableViewController

@property (strong, nonatomic) NSArray *sections;

- (NSArray *)sectionRows:(id)section;
- (NAFormTableSelectActionType)rowActionType:(id)row;
- (id)rowAtIndexPath:(NSIndexPath *)indexPath;
- (id)indexPathOfRow:(id)row;

- (void)initializeCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier row:(id)row;
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath row:(id)row;

- (void)willSelectByRow:(id)row;

- (void)willActionBacked:(UITableViewController *)controller;
- (void)willActionBackedByRow:(id)row;

@end
