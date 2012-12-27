//
//  NADictionaryTableViewCell.m
//  SK3
//
//  Created by nashibao on 2012/12/27.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import "NADictionaryTableViewCell.h"

@implementation NADictionaryTableViewCell

- (NSString *)text:(id)data{
    return data[@"text"];
}

- (NSString *)detailText:(id)data{
    return data[@"detailText"];
}

- (void)setData:(id)data{
    if([data isKindOfClass:[NSString class]]){
        [self.textLabel setText:data];
        [self.detailTextLabel setText:@""];
    }else if([data isKindOfClass:[NSDictionary class]]){
        [self.textLabel setText:[self text:data]];
        [self.detailTextLabel setText:[self detailText:data]];
    }else{
        [self.textLabel setText:@""];
        [self.detailTextLabel setText:@""];
    }
}

@end
