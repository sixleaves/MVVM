//
//  WexFirstViewModel.m
//  Weicaifu_MVVM
//
//  Created by 星星 on 17/1/20.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexFirstViewModel.h"
#import "WexMessageEntity.h"
#import "WexViewModel+HUD.h"


@interface WexFirstViewModel ()

@end

@implementation WexFirstViewModel

@dynamic delegate;
@dynamic navigationService;


- (void)viewDidLoad {
    
    [self showWaitHUD];
    
    [self.delegate
     firstViewModel:self
     loadDataWithComplete:^(WexMessageEntity *data, NSError *error) {
         
         if (data && !error) {
             [self showSuccessHUDWithStatus:@"成功"];
             [self setData:data];
         }
         else {
             [self showErrorHUDWithStatus:@"失败"];
         }
     }];
}



#pragma mark - 加载数据

- (void)setData:(WexMessageEntity *)data {
    _data = data;
    
    
    self.navigationItem.title = data.title;
    
    [self removeAllCells];
    [self loadAllCells];
    [self synchronizeAllCells];
}


#pragma mark - 加载Cell

- (void)loadAllCells {
    
    //
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"temp_cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"前往 -> %@", self.data.nextTitle];
    [self appendCell:cell toSection:0];
    
    //
    UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"temp_cell_2"];
    cell2.textLabel.text = [NSString stringWithFormat:@"打开照相机"];
    [self appendCell:cell2 toSection:0];
}


#pragma mark - TableView的操作

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        WexFirstViewModel *nvm = [[WexFirstViewModel alloc] init];
        [self.navigationService pushViewModel:nvm animated:true];
    }
    else {
        [self.navigationService presentCameraWithComplete:^(UIImage *image) {
            
        }];
    }
}


// ...
- (void)handleSubmit {
    
    [self.delegate firstViewModel:self submitWithArg1:@"arg1" complete:^(NSError *error) {
        
    }];
}

@end
