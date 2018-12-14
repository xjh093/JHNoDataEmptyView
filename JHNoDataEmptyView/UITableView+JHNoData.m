//
//  UITableView+JHNoData.m
//  JHKit
//
//  Created by HaoCold on 2017/12/29.
//  Copyright © 2017年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UITableView+JHNoData.h"
#import "JHNoDataEmptyView.h"
#import <objc/runtime.h>

@implementation UITableView (JHNoData)

/// exchange methods
+ (void)load{
    
    Method old = class_getInstanceMethod(self, @selector(reloadData));
    Method new = class_getInstanceMethod(self, @selector(jh_reloadData));
    
    method_exchangeImplementations(old, new);
}

- (void)setJh_showNoDataEmptyView:(BOOL)jh_showNoDataEmptyView{
    objc_setAssociatedObject(self, @selector(jh_showNoDataEmptyView), @(jh_showNoDataEmptyView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)jh_showNoDataEmptyView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

/// custom method
- (void)jh_reloadData
{
    [self jh_reloadData];
    
    if (![self jh_showNoDataEmptyView]) {
        return;
    }
    
    // find UITableViewWrapperView in self.subviews before iOS 11
    UIView *mmdView = nil;
    Class class = NSClassFromString(@"UITableViewWrapperView");
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class]) {
            mmdView = view;
            break;
        }
    }
    
    if (!mmdView) {
        mmdView = self;
    }
    
    NSInteger totalRows = 0;
    
    // if self.visibleCells.count > 0, tableView may be not empty.
    totalRows = self.visibleCells.count;
    
    // if self.visibleCells.count == 0, maybe tableHeaderView is too high!!!
    if (totalRows == 0) {
        for (NSInteger section = 0; section < self.numberOfSections; section++) {
            NSInteger rows = [self numberOfRowsInSection:section];
            totalRows += rows;
        }
    }
    
    if (totalRows > 0) {
        // remove custom views
        [mmdView.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([subview isKindOfClass:[JHNoDataEmptyView class]]) {
                [subview removeFromSuperview];
                *stop = YES;
            }
        }];
        
    }else{

        CGFloat tableHeaderViewHeight = 0;
        CGFloat tableFooterViewHeight = 0;
        if (self.tableHeaderView) {
            tableHeaderViewHeight = CGRectGetHeight(self.tableHeaderView.frame);
        }
        if (self.tableFooterView) {
            tableFooterViewHeight = CGRectGetHeight(self.tableFooterView.frame);
        }
        
        CGFloat height = tableHeaderViewHeight + tableFooterViewHeight;
        CGFloat tableViewHeight = CGRectGetHeight(self.frame);
        // if headerView's height and footerView' height is bigger than tableView's Height
        // there is not need to show the emptyview, because the tableview is full
        if (height > tableViewHeight) {
            return;
        }
        
        // add custom views in UITableViewWrapperView to offer some infomation.
        UILabel *label = nil;
        UIImageView *imageView = nil;
        
        if ([self.dataSource respondsToSelector:@selector(labelForTableViewWhenDataSourceIsEmpty)]) {
            label = [self.dataSource performSelector:@selector(labelForTableViewWhenDataSourceIsEmpty)];
        }
        
        if ([self.dataSource respondsToSelector:@selector(imageViewForTableViewWhenDataSourceIsEmpty)]) {
            imageView = [self.dataSource performSelector:@selector(imageViewForTableViewWhenDataSourceIsEmpty)];
        }
        
        // empty view
        CGFloat offsetY = self.contentOffset.y < 0 ? self.contentOffset.y : 0;
        CGRect bounds = CGRectMake(0, height, CGRectGetWidth(mmdView.frame), tableViewHeight - height + offsetY);
        JHNoDataEmptyView *emptyView = [JHNoDataEmptyView jh_emptyViewWithLabel:label imageView:imageView bounds:bounds backgroundColor:nil];
        [mmdView addSubview:emptyView];
        
        if ([self.delegate respondsToSelector:@selector(emptyViewForTableViewWhenDataSourceIsEmpty:)]) {
            [self.delegate performSelector:@selector(emptyViewForTableViewWhenDataSourceIsEmpty:) withObject:emptyView];
        }
    }
}

@end
