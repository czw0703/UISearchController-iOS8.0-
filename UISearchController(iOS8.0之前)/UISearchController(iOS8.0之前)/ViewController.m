//
//  ViewController.m
//  UISearchController(iOS8.0之前)
//
//  Created by mac on 16/6/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISearchDisplayController *mySearchVc;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;



@property(nonatomic,strong)NSMutableArray *datalist;
@property(nonatomic,strong)NSMutableArray *searchlist;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datalist=[NSMutableArray arrayWithCapacity:100];
    
    for (NSInteger i=0; i<100; i++) {
        [self.datalist addObject:[NSString stringWithFormat:@"%ld-row",i]];
    }
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    self.mySearchVc.delegate=self;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  这里判断返回哪个数据源单元格个数
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return self.searchlist.count;
    }else{
        
        return self.datalist.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"hahhaha";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        [cell.textLabel setText:self.searchlist[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.datalist[indexPath.row]];
    }
    
    return cell;
    
}

#pragma mark--UISearchDisplayDelegate

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    NSLog(@"搜索Begin");
//    return YES;
//}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    NSLog(@"搜索End");
//    return YES;
//}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self contains[c] %@",searchString];
    
    // 这里在查找之前把searchlist数组清空，不做这个处理也可以
    if (self.searchlist!=nil) {
        [self.searchlist removeAllObjects];
    }
    
    // 过滤数据
    self.searchlist= [NSMutableArray arrayWithArray:[self.datalist filteredArrayUsingPredicate:predicate]];
    //  刷新单元格
    return YES;
}

//点击监听方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        NSLog(@"点击了searchlist----%ld",indexPath.row);
    }else{
        NSLog(@"点击了datalist---%ld",indexPath.row);
        
    }
    
    
}
@end
