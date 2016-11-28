//
//  ANCollectionViewFlowLayout.m
//  CoverFlow
//
//  Created by skywalker on 16/11/28.
//  Copyright © 2016年 斯芬克斯. All rights reserved.
//

#import "ANCollectionViewFlowLayout.h"

@implementation ANCollectionViewFlowLayout
-(void)prepareLayout{

       CGFloat itemH = self.collectionView.bounds.size.height * 0.8;
    self.itemSize=CGSizeMake(itemH, itemH);
    
    self.minimumLineSpacing=3;
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
//    self.collectionView.bounces=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    
    CGFloat inset = (self.collectionView.bounds.size.width - itemH)* 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}
#pragma mark -刷新
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
   
    return YES;
}
#pragma mark -返回指定区域的cell的布局信息
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //遍历数组修改cell
    NSArray* attArray=[super layoutAttributesForElementsInRect:rect];
    NSMutableArray * arrM=[NSMutableArray array];
//屏幕中心x的坐标x
    CGFloat screenCenterX=self.collectionView.bounds.size.width * 0.5 + self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes  * attributes  in attArray)
    {
        UICollectionViewLayoutAttributes * needArr=attributes.copy;
        //获取每个cell的中心点x坐标
        CGFloat attrCenterX=needArr.center.x;
        CGFloat distance=ABS(screenCenterX -attrCenterX);
        //距离中心线越远缩得越小
        CGFloat scale=1-distance/self.collectionView.bounds.size.width;
        //定义左右
        BOOL isLeft =screenCenterX >attrCenterX?YES : NO ;
        //旋转
        CGFloat angle=(1-scale) * M_PI_4 * 3 *(isLeft ? 1 : -1);
        //定义单位矩阵
        CATransform3D  transform=CATransform3DIdentity;
        //透视效果
        transform.m34=-1.0 /1000;
        //缩放
        transform=CATransform3DRotate(transform, angle, 0, 1, 0);
        transform=CATransform3DScale(transform, scale, scale, 1);
        needArr.transform3D=transform;
        [arrM addObject:needArr];
    }
    
    return  arrM;
}
#pragma mark -返回cell的坐标
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGPoint p =[super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    //获取中心线坐标
     CGFloat screenCenterX=self.collectionView.bounds.size.width * 0.5 + self.collectionView.contentOffset.x;
    //获取可视区域
    CGRect rect =CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    //获取可视区域的cell所有信息
    NSArray * attrs=[self layoutAttributesForElementsInRect:rect];
    //最小值
    CGFloat minDistance=CGFLOAT_MAX;
    //记录布局信息
    UICollectionViewLayoutAttributes * needArr;
    for (UICollectionViewLayoutAttributes * attr in attrs) {
        CGFloat attrCenterX=attr.center.x;
        //获取距离中心线最近的cell的中心距离
        CGFloat distance=ABS(screenCenterX-attrCenterX);
        //找最小距离
        if (distance<minDistance) {
            minDistance=distance;
            needArr=attr;
        }
    }
    CGFloat needDistance=screenCenterX-needArr.center.x;
    return  CGPointMake(p.x -needDistance, 0);
}

@end
