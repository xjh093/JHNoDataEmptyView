//
//  UICollectionView+JHNoData.h
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

#import <UIKit/UIKit.h>

@protocol JHNoDataUICollectionViewDelegate <NSObject>

@optional

/// offer a image to show some infomation for user.
- (UIImageView *)imageViewForCollectionViewWhenDataSourceIsEmpty;

/// offer a label to show some infomation for user.
- (UILabel *)labelForCollectionViewWhenDataSourceIsEmpty;

/// the empty view that add to tableView. you can add more custom view.
- (void)emptyViewForCollectionViewWhenDataSourceIsEmpty:(UIView *)emptyView;

@end

@interface UICollectionView (JHNoData)

/**
 'NO' is default.
 If you want to show 'JHNoDataEmptyView' in one of your 'UICollectionView', you should set 'YES'.
 */
@property (nonatomic,  assign) BOOL  jh_showNoDataEmptyView;

@end
