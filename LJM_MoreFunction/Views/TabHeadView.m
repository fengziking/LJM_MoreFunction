//
//  TabHeadView.m
//  LM_MoreFunction
//
//  Created by 刘建明 on 2018/3/6.
//  Copyright © 2018年 余浩. All rights reserved.
//

#import "TabHeadView.h"
#import "BaseCollectionView.h"
#import "HomeCookbookCollectionViewLayout.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface TabHeadView ()<ALiLayoutDelegate>

@property(strong,nonatomic) HomeCookbookCollectionViewLayout *flowLayout;
@property(nonatomic,strong) BaseCollectionView *CollectionView;
@property (nonatomic, strong) NSMutableArray *images;

@end
@implementation TabHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];

    }
    return self;
}
-(void)creatUI{
    self.images = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        [self.images addObject:[NSString stringWithFormat:@"%tu",i]];
    }
    [self addSubview:self.CollectionView];
}
-(BaseCollectionView *)CollectionView {
    if (!_CollectionView) {
        _flowLayout = [[HomeCookbookCollectionViewLayout alloc] init];
        _flowLayout.isMove = YES;
        _flowLayout.delegate = self;
        //这种最小行间距
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.itemSize = CGSizeMake(80, 80);
        _flowLayout.headerReferenceSize = CGSizeMake(ScreenW , 30);
        _CollectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW , 300) collectionViewLayout:_flowLayout];
        _CollectionView.backgroundColor = [UIColor whiteColor];
        //此处给其增加长按手势，用此手势触发cell移动效果
        UITapGestureRecognizer *longGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [_CollectionView addGestureRecognizer:longGesture];
        _CollectionView.array = self.images;
    }
    return _CollectionView;
}
#pragma mark-移动改变数据源
- (void)moveDataItem:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
    id obj = [self.images objectAtIndex:fromIndexPath.item];
    [self.images removeObjectAtIndex:fromIndexPath.item];
    [self.images insertObject:obj atIndex:toIndexPath.item];
    NSLog(@"qweqweqweqwewq");
    
}
- (void)handleTapGesture:(UIGestureRecognizer *)gesture
{
    CGPoint loc = [gesture locationInView:self.CollectionView];
    __block BOOL isIn = YES;
    [[self.CollectionView visibleCells] enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, loc)) {
            isIn = YES;
            return ;
        } else {
            isIn = NO;
        }
    }];
    
    if (!isIn) {
        [[self.CollectionView visibleCells] enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.flowLayout stop:obj];
        }];
    }
}

@end
