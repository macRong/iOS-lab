//
//  CTDebugViewController.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/5.
//

#import "CTDebugViewController.h"
#import "CTDebugCollectionViewCell.h"
#import <Masonry.h>

@interface CTDebugViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

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
    
    [self.mainCollectionView reloadData]; //??
}

#pragma mark - ———————————————————— Override —————————————————

#pragma mark - ————————————— Net Connection Event ————————————

/** 数据加载 */
- (void)loadData
{
    
}

#pragma mark - ——————————————— Public Funcation ———————————————


#pragma mark - ————————— ————— Private Funcation ——————————————


#pragma mark - —————————————————— Touch Event —————————————————


#pragma mark - ————————————————— Delegate Event ———————————————

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 120;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTDebugCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CTDebugCollectionViewCell" forIndexPath:indexPath];
//    [cell loadUIWithModel:gczx_arr_getValidObject(self.dataList, indexPath.row)];

    return cell;
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
        
        self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.mainCollectionView.delegate = self;
        self.mainCollectionView.dataSource = self;
        self.mainCollectionView.backgroundColor = [UIColor whiteColor];
        [self.mainCollectionView registerClass:[CTDebugCollectionViewCell class] forCellWithReuseIdentifier:@"CTDebugCollectionViewCell"];
    }
    
    return _mainCollectionView;
}

@end
