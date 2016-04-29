//
//  YZQWaterflowLayout.h
//  瀑布流
//
//  Created by apple on 15/4/26.
//  Copyright © 2015年 YZQ. All rights reserved.
//
#import <UIKit/UIKit.h>

@class YZQWaterflowLayout;

@protocol YZQWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(YZQWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(YZQWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(YZQWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(YZQWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(YZQWaterflowLayout *)waterflowLayout;
@end

@interface YZQWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<YZQWaterflowLayoutDelegate> delegate;
@end
