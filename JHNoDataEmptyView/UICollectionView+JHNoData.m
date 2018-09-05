//
//  UICollectionView+JHNoData.m
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

#import "UICollectionView+JHNoData.h"
#import "JHNoDataEmptyView.h"

#import <objc/runtime.h>

@implementation UICollectionView (JHNoData)

/// exchange methods
+ (void)load{
    
    Method old = class_getInstanceMethod(self, @selector(reloadData));
    Method new = class_getInstanceMethod(self, @selector(jh_reloadData));
    
    method_exchangeImplementations(old, new);
}

#if kJHUICollectionViewNoDataPropertyChoose

- (void)setJh_hideNoDataEmptyView:(BOOL)jh_hideNoDataEmptyView{
    objc_setAssociatedObject(self, @selector(jh_hideNoDataEmptyView), @(jh_hideNoDataEmptyView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)jh_hideNoDataEmptyView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#else

- (void)setJh_showNoDataEmptyView:(BOOL)jh_showNoDataEmptyView{
    objc_setAssociatedObject(self, @selector(jh_showNoDataEmptyView), @(jh_showNoDataEmptyView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)jh_showNoDataEmptyView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#endif

/// custom method
- (void)jh_reloadData
{
    [self jh_reloadData];
    
#if kJHUICollectionViewNoDataPropertyChoose
    if ([self jh_hideNoDataEmptyView]) {
        return;
    }
#else
    if (![self jh_showNoDataEmptyView]) {
        return;
    }
#endif
    
    
    // issue: self.visibleCells.count == 0
    // https://stackoverflow.com/questions/26055626/uicollectionview-visiblecells-returns-0-before-scrolling
    [self layoutIfNeeded];
    
    // if self.visibleCells.count > 0, so collectionView is not empty.
    if (self.visibleCells.count) {
        
        // remove custom views
        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([subview isKindOfClass:[JHNoDataEmptyView class]]) {
                [subview removeFromSuperview];
            }
        }];
        
    }else{
        
        // add custom views to offer some infomation.
        
        UILabel *label = nil;
        UIImageView *imageView = nil;
        
        if ([self.delegate respondsToSelector:@selector(labelForCollectionViewWhenDataSourceIsEmpty)]) {
            label = [self.delegate performSelector:@selector(labelForCollectionViewWhenDataSourceIsEmpty)];
        }
        
        if ([self.delegate respondsToSelector:@selector(imageViewForCollectionViewWhenDataSourceIsEmpty)]) {
            imageView = [self.delegate performSelector:@selector(imageViewForCollectionViewWhenDataSourceIsEmpty)];
        }
        
        // empty view
        JHNoDataEmptyView *emptyView = [JHNoDataEmptyView jh_emptyViewWithLabel:label imageView:imageView bounds:self.bounds backgroundColor:nil];
        [self addSubview:emptyView];
        
        if ([self.delegate respondsToSelector:@selector(emptyViewForCollectionViewWhenDataSourceIsEmpty:)]) {
            [self.delegate performSelector:@selector(emptyViewForCollectionViewWhenDataSourceIsEmpty:) withObject:emptyView];
        }
    }
}

@end
