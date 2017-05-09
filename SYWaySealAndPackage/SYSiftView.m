//
//  SYSiftView.m
//  CommonlyUsedFile
//
//  Created by 666gps on 2017/5/9.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import "SYSiftView.h"
#import "SYButtonImagePlace.h"

#define WindowWidth [UIScreen mainScreen].bounds.size.width
#define WindowHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorWithRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


@implementation SYSiftView{
    NSInteger nowSelectButton;/**<现在点击的是那个按钮*/
    BOOL isShowTableView;/**<判断选项列表是否显示状态，yes显示状态，no隐藏状态*/
    NSArray * showTableViewDataArray;/**<要显示的tableview的数据源*/
    NSString * showTitle;/**<记住显示的是哪一个button的标题，用于标记下面的选择项*/
}
-(instancetype)initWithFrame:(CGRect)frame DataArray:(NSArray *)dataArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = dataArray;
        self.buttonTitleArray = [[NSMutableArray alloc]init];
        [self addButton];
        
    }
    return self;
}
//这里加载button
-(void)addButton{
    self.disButtonA.frame = CGRectMake(0, 0, WindowWidth, 0);
    self.selectNumberArray = [[NSMutableArray alloc]init];
    float buttonW = WindowWidth / self.dataArray.count;
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[self.dataArray[i] objectForKey:@"buttonTitle"] forKey:@"title"];
        [dic setValue:[NSNumber numberWithInteger:-1] forKey:@"selectNumber"];
        
        SYButtonImagePlace * button = [self creatTopButton];
        NSString * title = [self.dataArray[i] objectForKey:@"buttonTitle"];
        [self.buttonTitleArray addObject:title];
        if (title.length > 4) {
            title = [title substringWithRange:NSMakeRange(0,3)];
            [button setTitle:[NSString stringWithFormat:@"%@...",title] forState:UIControlStateNormal];
        }else{
            [button setTitle:title forState:UIControlStateNormal];
        }
        button.frame = CGRectMake(buttonW * i, 0, buttonW, 44);
        button.tag = 369000 + i;
        [button addTarget:self action:@selector(showDownTableView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [dic setValue:[NSNumber numberWithInteger:button.tag] forKey:@"buttonTag"];
        [self.selectNumberArray addObject:dic];
        
    }
    
}
//处理button的点击事件
-(void)showDownTableView:(UIButton *)selectButton{
    if (nowSelectButton == selectButton.tag) {
        [self hideTableView];
    }else{
        if (isShowTableView == YES) {
            [self hideTableView];
        }else{
            showTitle = [self.dataArray[selectButton.tag - 369000] objectForKey:@"buttonTitle"];
            nowSelectButton = selectButton.tag;
            [self showTableView];
        }
    }
}
//显示选项列表
-(void)showTableView{
    if (showTableViewDataArray.count > 0) {
        showTableViewDataArray = [NSArray new];
    }
    showTableViewDataArray = [self.dataArray[nowSelectButton - 369000] objectForKey:@"alternativeArray"];
    self.selectBlock(nowSelectButton - 369000);
    [UIView animateWithDuration:0.2 animations:^{
        if (showTableViewDataArray.count <= 5) {
            self.listTableView.frame = CGRectMake(0, 44, WindowWidth, showTableViewDataArray.count * 40);
        }else{
            self.listTableView.frame = CGRectMake(0, 44, WindowWidth, 200);
        }
        [self.listTableView reloadData];
    }];
    self.disButtonA.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
}
//隐藏选项列表
-(void)hideTableView{
    showTitle = nil;
    nowSelectButton = -1;
    self.selectBlock(-1);
    [UIView animateWithDuration:0.2 animations:^{
        self.listTableView.frame = CGRectMake(0, 44, WindowWidth, 0);
    }];
    self.disButtonA.frame = CGRectMake(0, 0, WindowWidth, 0);
}
//tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return showTableViewDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    for (NSMutableDictionary * dic in self.selectNumberArray) {
        if ([[dic objectForKey:@"buttonTag"] integerValue] == nowSelectButton) {
            NSInteger nu = [[dic objectForKey:@"selectNumber"] integerValue];
            if (indexPath.row == nu) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    cell.textLabel.text = showTableViewDataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NSMutableDictionary * dic in self.selectNumberArray) {
        if ([[dic objectForKey:@"buttonTag"] integerValue] == nowSelectButton) {
            [dic setValue:[NSNumber numberWithInteger:indexPath.row] forKey:@"selectNumber"];
            if (indexPath.row == 0) {
                NSString * title = self.buttonTitleArray[nowSelectButton - 369000];
                SYButtonImagePlace * btn = (SYButtonImagePlace *)[self viewWithTag:nowSelectButton];
                if (title.length > 4) {
                    NSString * til = [title substringWithRange:NSMakeRange(0, 3)];
                    title = [NSString stringWithFormat:@"%@...",til];
                }
                [btn setTitle:title forState:UIControlStateNormal];
                
            }else{
                NSString * title = showTableViewDataArray[indexPath.row];
                SYButtonImagePlace * btn = (SYButtonImagePlace *)[self viewWithTag:nowSelectButton];
                if (title.length > 4) {
                    NSString * til = [title substringWithRange:NSMakeRange(0, 3)];
                    title = [NSString stringWithFormat:@"%@...",til];
                }
                [btn setTitle:title forState:UIControlStateNormal];
            }
        }
    }
    [self.listTableView reloadData];
    if (_delegate) {
        [_delegate selectDataArrayIndex:nowSelectButton - 369000 AlternativeArray:indexPath.row];
        [self hideTableView];
    }
}
//懒加载tableview
-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, WindowWidth, 0) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.rowHeight = 40;
        _listTableView.tableFooterView = [UIView new];
        [self addSubview:_listTableView];
    }
    return _listTableView;
}
-(UIButton *)disButtonA{
    if (!_disButtonA) {
        _disButtonA = [UIButton buttonWithType:UIButtonTypeCustom];
        _disButtonA.backgroundColor = [UIColor blackColor];
        _disButtonA.alpha = 0.3;
        [_disButtonA addTarget:self action:@selector(disButtonAAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_disButtonA];
    }
    return _disButtonA;
}
-(void)disButtonAAction{
    [self hideTableView];
}
//这里修改button文字和图标的位置
-(SYButtonImagePlace *)creatTopButton{
    SYButtonImagePlace * button = [SYButtonImagePlace buttonWithType:UIButtonTypeCustom];
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderColor:UIColorFromRGB(0xDDDDDD).CGColor];
    [button.layer setBorderWidth:1];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"map_icon_down"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    return button;
}
@end
