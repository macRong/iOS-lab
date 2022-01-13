//
//  CTDebugViewController.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/5.
//

#import "CTDebugViewController.h"
#import "CTDebugCollectionViewCell.h"
#import "CTDebugHeaderView.h"
#import "CTDebugListViewModel.h"
#import "CTDebugCellProtocol.h"

@interface CTDebugViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) CTDebugListViewModel *viewModel;

@end

@implementation CTDebugViewController

#pragma mark -  ——————————————————— LifeCycle ———————————————————

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 初始化变量
    [self initVars];

    // 初始化界面
    [self initViews];
    
    // 数据请求
    [self loadData];
}

#pragma mark -  ————————————————— init and config ——————————————

/** 初始化变量 */
- (void)initVars
{
    
}

/** 初始化界面 */
- (void)initViews
{
    [self initNavView];
    [self initMainViews];
}

/** 初始化Nav导航栏 */
- (void)initNavView
{
    self.title = @"Debug";
}

/** 创建相关子view */
- (void)initMainViews
{
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - ———————————————————— Override —————————————————

#pragma mark - ————————————— Net Connection Event ————————————

/** 数据加载 */
- (void)loadData
{
    self.viewModel = [CTDebugListViewModel new];
    [self.mainCollectionView reloadData];
}

#pragma mark - ——————————————— Public Funcation ———————————————

#pragma mark - ————————— ————— Private Funcation ——————————————

#pragma mark - —————————————————— Touch Event —————————————————

#pragma mark - ————————————————— Delegate Event ———————————————

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.viewModel.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CTDebugCellModel *sectionCellModel = self.viewModel.dataArray[section];
    NSArray *dataArr = sectionCellModel.dataSource;
    NSInteger count = [dataArr isKindOfClass:[NSArray class]] ? dataArr.count : 0;
                       
    return count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTDebugCellModel *sectionCellmodel = self.viewModel.dataArray[indexPath.section];
    CTDebugCellModel *cellModel = sectionCellmodel.dataSource[indexPath.row];
    
    Class <CTDebugCellProtocol>cls = NSClassFromString(cellModel.cellID);
    id <CTDebugCellProtocol>cell = [collectionView dequeueReusableCellWithReuseIdentifier:(cellModel.cellID) forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerClass:cls forCellWithReuseIdentifier:cellModel.cellID]; ///注意这里没有动态
    }
    [cell cellModel:cellModel];
    
    return (UICollectionViewCell *)cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTDebugCellModel *sectionCellmodel = self.viewModel.dataArray[indexPath.section];
    CTDebugCellModel *cellModel = sectionCellmodel.dataSource[indexPath.row];
    [cellModel callBackAction];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *resultView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        resultView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                        withReuseIdentifier:@"CTDebugHeaderViewID"
                                                               forIndexPath:indexPath];
        CTDebugCellModel *sectionCellmodel = self.viewModel.dataArray[indexPath.section];
        [(CTDebugHeaderView *)resultView loadUIForTitle:sectionCellmodel.title];
    }
    
    return resultView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(200, 20);
}

#pragma mark - ————————————————— Setter/Getter ————————————————

- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4, 99);
        layout.sectionHeadersPinToVisibleBounds = YES;
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerClass:[CTDebugHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CTDebugHeaderViewID"];
        
        [self.mainCollectionView registerClass:[CTDebugCollectionViewCell class] forCellWithReuseIdentifier:@"CTDebugCollectionViewCell"]; ///注意这里没有动态
    }
    
    return _mainCollectionView;
}

@end
