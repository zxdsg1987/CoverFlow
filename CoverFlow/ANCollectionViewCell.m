//
//  ANCollectionViewCell.m
//  CoverFlow
//
//  Created by skywalker on 16/11/28.
//  Copyright © 2016年 斯芬克斯. All rights reserved.
//

#import "ANCollectionViewCell.h"
@interface ANCollectionViewCell()
@property(nonatomic,weak)UIImageView * imageView;
@end
@implementation ANCollectionViewCell
-(void)setImage:(UIImage *)image{
    _image=image;
    self.imageView.image=image;
    self.imageView.alpha=1.0;
    self.minimumPageAlpha=1.0;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}
-(void)setupUI{
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"commom-1"]];
    imageView.frame=self.bounds;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    imageView.layer.cornerRadius = 5;
    imageView.layer.borderColor = [UIColor brownColor].CGColor;
    imageView.layer.borderWidth = 2;
    //圆角属性
    imageView.layer.masksToBounds = YES;
    self.imageView = imageView;
    
}
@end
