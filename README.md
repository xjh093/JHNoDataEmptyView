# JHNoDataEmptyView
empty view for tableview and collectionview
- tableview 与 collectionview 的空白占位图

---

# Version
Latest release version:
- [1.2.0](https://github.com/xjh093/JHNoDataEmptyView/releases)

---

# Cocoapods
`pod 'JHNoDataEmptyView'`

---

# Logs

4.add Demo and fix bugs.(2018-12-14)
- header view or footer view is too high.
- remove property 'jh_hideNoDataEmptyView'.

3.add property 'jh_showNoDataEmptyView'.(2018-9-5)
- suggest you to use this property, 'jh_hideNoDataEmptyView' is also keeped. You can choose one of them.
- automatic show effect too big, some system's collectionView is also effected.

2.replace 'jh_showAutomatic' to 'jh_hideNoDataEmptyView'.(2018-7-24)
- set 'YES' if you do not want to show the 'JHNoDataEmptyView'

~1.add property 'jh_showAutomatic'.(2018-07-23)~

- ~default is 'YES'~

- ~set 'NO' if you do not want to show the 'JHNoDataEmptyView'~

---

## implement delegate to offer more infomations
## delegate for UICollectionView
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

## delegate for UITableView
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
