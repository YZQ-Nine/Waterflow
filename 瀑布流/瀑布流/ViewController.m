//
//  ViewController.m
//  瀑布流
//
//  Created by apple on 15/4/26.
//  Copyright © 2015年 YZQ. All rights reserved.
//

#import "ViewController.h"
#import "YZQWaterflowLayout.h"
#import "YZQModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "YZQModelCell.h"

@interface ViewController () <UICollectionViewDataSource, YZQWaterflowLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *models;

@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController

- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

static NSString * const YZQModelId = @"model";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.footer.hidden = YES;
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"];
        NSData *dataFile = [NSData dataWithContentsOfFile:path];
        NSArray *tempArray = nil;
     
        tempArray = [NSJSONSerialization JSONObjectWithData:dataFile options:NSJSONReadingAllowFragments error:nil];
        
        [self.models removeAllObjects];
//        self.models = [NSMutableArray array];
        for (NSDictionary *dic in tempArray) {
             YZQModel *m = [[YZQModel alloc] init];
            [m setValuesForKeysWithDictionary:dic];
            [self.models addObject:m];
        }

        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"];
        NSData *dataFile = [NSData dataWithContentsOfFile:path];
        NSArray *tempArray = nil;
        
        tempArray = [NSJSONSerialization JSONObjectWithData:dataFile options:NSJSONReadingAllowFragments error:nil];
        
     
    
//        self.models = [NSMutableArray array];
        for (NSDictionary *dic in tempArray) {
            YZQModel *m = [[YZQModel alloc] init];
            [m setValuesForKeysWithDictionary:dic];
            [self.models addObject:m];
        }
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];
    });
}

- (void)setupLayout
{
    // 创建布局
    YZQWaterflowLayout *layout = [[YZQWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YZQModelCell class]) bundle:nil] forCellWithReuseIdentifier:YZQModelId];

    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.models.count == 0;
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YZQModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YZQModelId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    YZQModel *model = self.models[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - <XMGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(YZQWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    YZQModel *model = self.models[index];
    
    return itemWidth * model.height / model.width;
}

- (CGFloat)rowMarginInWaterflowLayout:(YZQWaterflowLayout *)waterflowLayout
{
    return 20;
}

- (CGFloat)columnCountInWaterflowLayout:(YZQWaterflowLayout *)waterflowLayout
{
//    if (self.shops.count <= 50) return 2;
    return 3;
}

//- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(YZQWaterflowLayout *)waterflowLayout
//{
//    return UIEdgeInsetsMake(10, 20, 30, 100);
//}
@end

