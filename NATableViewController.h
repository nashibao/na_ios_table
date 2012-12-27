//
//  NATableViewController.h
//  SK3
//
//  Created by nashibao on 2012/10/01.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NATableViewController : UITableViewController

/*
 default: NO
 storyboardなどで作った静的テーブルの場合はここをYESに．
 */
@property (nonatomic) BOOL isStaticTable;

/*
 UITableViewのselectedIndexPathとは異なり、UINavigationBarのBackボタンなどで戻ってきても選択されたままに
 なる．
 */
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

// デフォルトのセルスタイル
@property (nonatomic) UITableViewCellStyle cellStyle;
@property (strong, nonatomic) Class cellClass;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (nonatomic) UITableViewCellAccessoryType cellAccessoryType;


// ローディング中かどうか
@property (readonly, nonatomic) BOOL isLoading;


#pragma mark UITableViewDataSource delegateのラッパー

//セル初期化
- (void)initializeCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier;

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


#pragma mark オーバーライドするメソッド

//初期化
- (void)setupTableViewController;


/*
 表示のupdate.
 */
- (void)updateTable;


/*
 データロード
 */
- (void)loadData;


/*
 default: NO
 */
@property (nonatomic) BOOL enableRefleshControl;

#pragma mark データロード(アップロード)delegate(風)

/*
 ロード前
 */
- (void)willLoadData;

/*
 ロード後
 */
- (void)didLoadHandlerWithError:(NSError *)err;

@end
