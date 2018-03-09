//
//  HomeCell.m
//  LM_MoreFunction
//
//  Created by 余浩 on 2018/3/4.
//  Copyright © 2018年 余浩. All rights reserved.
//

#import "HomeCell.h"
#import "HomeCookbookCollectionViewLayout.h"
#import "BaseCollectionView.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface HomeCell ()

@property(strong,nonatomic) HomeCookbookCollectionViewLayout *flowLayout;

@end

@implementation HomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{

}

-(void)setCollectionHigh:(int)CollectionHigh{
    _CollectionHigh = CollectionHigh;
    [self addSubview:self.CollectionView];

}
-(BaseCollectionView *)CollectionView {
    if (!_CollectionView) {
        _flowLayout = [[HomeCookbookCollectionViewLayout alloc] init];
        _flowLayout.isMove = NO;
        //这种最小行间距
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.itemSize = CGSizeMake(80, 80);
        _flowLayout.headerReferenceSize = CGSizeMake(ScreenW , 30);
        _CollectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW , 200) collectionViewLayout:_flowLayout];
       // _CollectionView.array = self.array;
    }
    return _CollectionView;
}





@end
