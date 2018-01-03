//
//  JHNoDataEmptyView.m
//  JHKit
//
//  Created by HaoCold on 2018/1/2.
//  Copyright © 2018年 HaoCold. All rights reserved.
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

#import "JHNoDataEmptyView.h"

@implementation JHNoDataEmptyView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    }
    return self;
}

+ (JHNoDataEmptyView *)jh_emptyViewWithLabel:(UILabel *)label imageView:(UIImageView *)imageView bounds:(CGRect)bounds backgroundColor:(UIColor *)backgroundColor
{
    JHNoDataEmptyView *emptyView = nil;
    
    if (label && imageView) {
        emptyView = [self jh_addLabel:label imageView:imageView bounds:bounds];
    }else if (label){
        emptyView = [self jh_addLabel:label bounds:bounds];
    }else if (imageView){
        emptyView = [self jh_addImageView:imageView bounds:bounds];
    }else{
        emptyView = [self jh_addDefaultLabel:bounds];
    }
    
    if (backgroundColor) {
        emptyView.backgroundColor = backgroundColor;
    }
    
    return emptyView;
}

+ (JHNoDataEmptyView *)jh_addLabel:(UILabel *)label imageView:(UIImageView *)imageView bounds:(CGRect)bounds
{
    JHNoDataEmptyView *emptyView = [[JHNoDataEmptyView alloc] init];
    emptyView.frame = bounds;
    
    [emptyView addSubview:imageView];
    [emptyView addSubview:label];
    
    imageView.center = CGPointMake(emptyView.center.x, emptyView.center.y - imageView.bounds.size.height * 0.5 - 5);
    label.center = CGPointMake(emptyView.center.x, emptyView.center.y + label.bounds.size.height * 0.5 + 5);
    
    return emptyView;
}

+ (JHNoDataEmptyView *)jh_addLabel:(UILabel *)label bounds:(CGRect)bounds
{
    JHNoDataEmptyView *emptyView = [[JHNoDataEmptyView alloc] init];
    emptyView.frame = bounds;
    
    label.center = emptyView.center;
    [emptyView addSubview:label];
    
    return emptyView;
}

+ (JHNoDataEmptyView *)jh_addImageView:(UIImageView *)imageView bounds:(CGRect)bounds
{
    JHNoDataEmptyView *emptyView = [[JHNoDataEmptyView alloc] init];
    emptyView.frame = bounds;
    
    imageView.center = emptyView.center;
    [emptyView addSubview:imageView];
    
    return emptyView;
}

+ (JHNoDataEmptyView *)jh_addDefaultLabel:(CGRect)bounds
{
    JHNoDataEmptyView *emptyView = [[JHNoDataEmptyView alloc] init];
    emptyView.frame = bounds;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = emptyView.bounds;
    label.numberOfLines = 0;
    label.text = @"暂无数据哦~\noops~\nThere is nothing here~";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [emptyView addSubview:label];
    
    return emptyView;
}

@end
