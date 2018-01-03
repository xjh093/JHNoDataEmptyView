# JHNoDataEmptyViewForT-C
empty view for tableview and collectionview

### base on : visibleCells

### implement delegate to offer more infomations
### delegate for UICollectionView
```
@protocol JHNoDataUICollectionViewDelegate <NSObject>

@optional

/// offer a image to show some infomation for user.
- (UIImageView *)imageViewForCollectionViewWhenDataSourceIsEmpty;

/// offer a label to show some infomation for user.
- (UILabel *)labelForCollectionViewWhenDataSourceIsEmpty;

/// the empty view that add to tableView.
- (void)emptyViewForCollectionViewWhenDataSourceIsEmpty:(UIView *)emptyView;

@end

```

### delegate for UITableView
```
@protocol JHNoDataUITableViewDelegate <NSObject>

@optional

/// offer a image to show some infomation for user.
- (UIImageView *)imageViewForTableViewWhenDataSourceIsEmpty;

/// offer a label to show some infomation for user.
- (UILabel *)labelForTableViewWhenDataSourceIsEmpty;

/// the empty view that add to tableView.
- (void)emptyViewForTableViewWhenDataSourceIsEmpty:(UIView *)emptyView;

@end

```
