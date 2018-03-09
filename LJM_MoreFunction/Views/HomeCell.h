//
//  HomeCell.h
//  LM_MoreFunction
//
//  Created by 余浩 on 2018/3/4.
//  Copyright © 2018年 余浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseCollectionView;
@interface HomeCell : UITableViewCell

@property(strong,nonatomic)NSString *rowStr;

@property(nonatomic,strong) NSArray *array;

@property(nonatomic,strong) BaseCollectionView *CollectionView;

@property(nonatomic,assign) int CollectionHigh;

@end
