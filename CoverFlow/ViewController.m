//
//  ViewController.m
//  CoverFlow
//
//  Created by skywalker on 16/11/28.
//  Copyright © 2016年 斯芬克斯. All rights reserved.
//

#import "ViewController.h"
#import "ANCollectionViewFlowLayout.h"
#import "ANCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource>
//存储数据
@property(nonatomic,strong)NSArray * imageArr;

@end
static NSString * cellID =@"cellID";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.imageArr=  [self loadData];
    [self buildCollectionView];
   
}
#pragma mark -加载数据
-(NSArray* )loadData{
    
    NSMutableArray * arrM=[[NSMutableArray alloc]init];
   //懒加载
    if (self.imageArr == nil) {
        for (int i=0; i<9; i++) {
            NSString * imageName=[NSString stringWithFormat:@"commom-%zd",i+1];
            UIImage * image=[UIImage imageNamed:imageName];
            [arrM addObject:image];
        }
        self.imageArr=arrM;
    }
    return arrM.copy;
}



#pragma mark -创建CollectionView
-(void)buildCollectionView{
    ANCollectionViewFlowLayout * flowLayout=[[ANCollectionViewFlowLayout alloc]init];
    UICollectionView * collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 200)  collectionViewLayout:flowLayout];
    collectionView.dataSource=self;
    collectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:collectionView];
    //注册
    [collectionView registerClass:[ANCollectionViewCell class] forCellWithReuseIdentifier:cellID];
}
#pragma mark -数据源方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count ;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ANCollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //设置cell
       cell.image = self.imageArr[indexPath.item % 9];
    
    return cell;
                                  
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
