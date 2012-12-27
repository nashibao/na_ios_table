# `na_ios_table`

`na_ios_table`は、coredataに`UITableViewController`を接続する際に必要な多くの処理を肩代わりしてくれる便利なモジュールです．
まずは例を見てみましょう．

```
#import "NAFRCTableViewController.h"
@interface HogeTableViewController : NAFRCTableViewController
@end

@implementation HogeTableViewController

- (void)setupTableViewController{
    NSFetchedResultsController *frc = [Hoge controllerWithEqualProps:@{@"name": @"test"} sorts:@[@"pk"] context:nil options:nil];
    [frc performFetch:nil];
    self.fetchedResultsController = frc;
}

@end
```

That's it!これだけです．これで、`NAFRCTableViewController`は`name=@"test"`な`Hoge`をテーブルにロードしてくれます．

`UITableViewCell`には`NSManagedObjectID`が表示されているかと思います．それではセルをカスタムしましょう．

```
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withMO:(NSManagedObject *)mo{
    Hoge *hoge = (Hoge *)mo;
    [cell.textLabel setText:hoge.title];
    [cell.detailTextLabel setText:[hoge.start_date stringWithFormat:@"M/dd"]];
}
```

`setupTableViewController`でデフォルトのセルに関する設定ができます．

```
- (void)setupTableViewController{
    self.cellIdentifier = @"HogeCell";
    self.cellClass = [HogeCell class];
    self.cellStyle = UITableViewCellStyleSubtitle;
    self.cellAccessoryType = UITableViewCellAccessoryCheckmark;
	...
}
```

また`NATableViewController`では「押し下げて取得」も自動で追加することが出来ます．

```
- (void)setupTableViewController{
	...
    self.enableRefleshControl = YES;
}
- (void)loadData{
    [super loadData];
    [Hoge sync_get:^(NSError *err) {
        [self didLoadHandlerWithError:err];
    }];
}
```

このとき`didLoadHandlerWithError`にエラーを渡すと、自動でデータ再取得のための`UIActionSheet`を出してくれます．

## todo

 - SVProgressHUDはUIActivityIndicatorManagerからこっちに移行すべき？？
 - フォーム対応