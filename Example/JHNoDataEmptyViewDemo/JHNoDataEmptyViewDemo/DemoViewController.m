//
//  DemoViewController.m
//  JHNoDataEmptyViewDemo
//
//  Created by HaoCold on 2018/12/14.
//  Copyright © 2018 HaoCold. All rights reserved.
//

#import "DemoViewController.h"
#import "UITableView+JHNoData.h"

@interface DemoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,  strong) UITableView *tableView;
@property (nonatomic,  strong) NSArray *dataArray;

@property (nonatomic,  strong) UIButton *button;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    [self xjh_setupViews];
    
}

#pragma mark -------------------------------------视图-------------------------------------------

- (void)xjh_setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.jh_showNoDataEmptyView = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 40, 40);
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:@"清空" forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setImage:nil forState:0];
        [button addTarget:self action:@selector(buttonEvent) forControlEvents:1<<6];
        _button = button;
        button;
    })];
    
    if (_row == 0) {
        
    }else if (_row == 1) {
        self.tableView.tableHeaderView = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 900);
            label.text = @"This\nis\na\ntable\nheader\nview\nit\nis\nvery\nhigh!!!";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor lightGrayColor];
            label.numberOfLines = 0;
            label;
        });
    }else if (_row == 2) {
        self.tableView.tableFooterView = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 900);
            label.text = @"This\nis\na\ntable\nfooter\nview\nit\nis\nvery\nhigh!!!";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor lightGrayColor];
            label.numberOfLines = 0;
            label;
        });
    }else if (_row == 3) {
        self.tableView.tableHeaderView = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100);
            label.text = @"This is a table header view";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor lightGrayColor];
            label.numberOfLines = 0;
            label;
        });
        
        self.tableView.tableFooterView = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100);
            label.text = @"This is a table header view";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor lightGrayColor];
            label.numberOfLines = 0;
            label;
        });
    }
}

#pragma mark -------------------------------------事件-------------------------------------------

- (void)buttonEvent
{
    if ([_button.currentTitle isEqualToString:@"清空"]) {
        [_button setTitle:@"重置" forState:0];
        _dataArray = @[];
    }else{
        [_button setTitle:@"清空" forState:0];
        _dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    [_tableView reloadData];
}

#pragma mark --- JHNoDataUITableViewDelegate

/// offer a image to show some infomation for user.
- (UIImageView *)imageViewForTableViewWhenDataSourceIsEmpty
{
    // you imageView
    return nil;
}

/// offer a label to show some infomation for user.
- (UILabel *)labelForTableViewWhenDataSourceIsEmpty
{
    // you label
    
    if (_row == 3) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 200, 80);
        label.text = @"if you don't want to show this empty view,you can hide it.";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        return label;
    }
    return nil;
}

/// the empty view that add to tableView. you can add more custom view.
- (void)emptyViewForTableViewWhenDataSourceIsEmpty:(UIView *)emptyView
{
    // you can add some custom view, button etc.
    
    if (_row == 3) { // Example 4
        // there are table header view and table footer view
        // if you don't want to show the emptyview, hide it.
        // emptyView.hidden = YES;
        // or
        // self.tableView.jh_showNoDataEmptyView = NO;
        // this will effect at next reload.
    }
}

#pragma mark --- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"resueID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行",@(indexPath.row)];
    return cell;
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:0];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 40;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        _tableView = tableView;
    }
    return _tableView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
