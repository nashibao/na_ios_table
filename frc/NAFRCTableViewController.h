//
//  NAFRCTableViewController.h
//  SK3
//
//  Created by nashibao on 2012/09/28.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "NATableViewController.h"

/*
 frcをつかったtable.
 */
@interface NAFRCTableViewController : NATableViewController

//frc
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

//frcとcellのバインド
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withMO:(NSManagedObject *)mo;

@end
