//
//  BaseCollectionView.h
//  LM_MoreFunction
//
//  Created by 刘建明 on 2018/3/6.
//  Copyright © 2018年 余浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic,strong) NSArray *array;

@end
