//
//  NATextLabelCell.h
//  SK3
//
//  Created by nashibao on 2012/10/15.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 辞書(json)形式をそのまま扱えるように変更.
@{
    @"text": hoge,
    @"detailText": hoge2,
}
 形式のデータを直接描画する
 */
@interface NATableViewCell : UITableViewCell

// tableViewへのweak参照
@property (weak, nonatomic) UITableViewController *tableViewController;

// 描画とデータが一体の場合に有用
@property (strong, nonatomic) id data;

@end
