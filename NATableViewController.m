//
//  NATableViewController.m
//  SK3
//
//  Created by nashibao on 2012/10/01.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import "NATableViewController.h"

#import "NATableViewCell.h"

#import "UITableView+na.h"

#import "ISRefreshControl.h"

@interface NATableViewController ()

@end

@implementation NATableViewController

#pragma mark initialization

- (void)_setupTableViewController{
    _isLoading = NO;
    self.isStaticTable = NO;
    self.cellClass = [UITableViewCell class];
    self.cellIdentifier = @"Cell";
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    [self setupTableViewController];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self _setupTableViewController];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self _setupTableViewController];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if(self){
        [self _setupTableViewController];
    }
    return self;
}


#pragma mark UIViewController delegate

- (void)viewDidLoad{
    [super viewDidLoad];
    if(self.enableRefleshControl){
        self.refreshControl = (id)[[ISRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(refreshed:) forControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark UITableViewDataSource delegate カスタマイズ部分


- (void)initializeCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier{
}

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    //    NATableViewCellの場合の対応
    if([cell isKindOfClass:[NATableViewCell class]]){
        NATableViewCell *ncell = (NATableViewCell *)cell;
        ncell.tableViewController = self;
    }
}


#pragma mark UITableViewDataSource delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    if(self.isStaticTable){
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        [cell setAccessoryType:self.cellAccessoryType];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
        if(!cell){
            cell = [[self.cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:self.cellIdentifier];
            [cell setAccessoryType:self.cellAccessoryType];
            [self initializeCell:cell atIndexPath:indexPath reuseIdentifier:self.cellIdentifier];
        }
    }
    
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    selectedIndexPathのアップデートと、選択時のアニメーションの自動化
    NSIndexPath *oldIndexPath = self.selectedIndexPath;
    NSArray *temp = nil;
    if(oldIndexPath
       &&
       (oldIndexPath.section != indexPath.section || oldIndexPath.row != indexPath.row)
       &&
       [self.tableView hasIndexPath:oldIndexPath]
       ){
        temp = @[oldIndexPath, indexPath];
    }else{
        temp = @[indexPath];
    }
    self.selectedIndexPath = indexPath;
    if(!self.isStaticTable){
        [tableView reloadRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark table apis カスタマイズ部分

- (void)setupTableViewController{}


- (void)updateTable{
    [self.tableView reloadData];
}

- (void)loadData{
    [self willLoadData];
    [self didLoadHandlerWithError:nil];
}

#pragma mark refresh control

- (void)willLoadData{
    _isLoading = YES;
    [self.refreshControl beginRefreshing];
    [self updateTable];
}

- (void)didLoadHandlerWithError:(NSError *)err{
    _isLoading = NO;
    [self.refreshControl endRefreshing];
    [self updateTable];
    if(err){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"データの取得に失敗しました．"];
        [sheet addButtonWithTitle:@"再取得" handler:^{
            [self loadData];
        }];
        [sheet setCancelButtonWithTitle:@"何もしない．" handler:nil];
        [sheet showInView:self.view];
    }
}

- (void)refreshed:(UIRefreshControl *)control{
    [self loadData];
}

#pragma mark - Table view delegate

@end
