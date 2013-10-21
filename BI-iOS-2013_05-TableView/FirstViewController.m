//
//  FirstViewController.m
//  BI-iOS-2013_05-TableView
//
//  Created by Jakub Hladík on 21.10.13.
//  Copyright (c) 2013 Flowknight s.r.o. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstCell.h"

@interface FirstViewController ()

@property (weak, nonatomic) UITableView *tableView;
@property (readonly) NSMutableArray *dataArray;

@end

@implementation FirstViewController

@synthesize dataArray = _dataArray;

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [@[@"Jakub", @"Natalka", @"Dominik"] mutableCopy];
    }
    return _dataArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Titulek";
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(removeButtonAction:)];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction:) forControlEvents:UIControlEventValueChanged];
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    tableView.dataSource = self;
//    tableView.delegate = self;
    
    [self.tableView registerClass:[FirstCell class] forCellReuseIdentifier:@"cell"];
    
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
    
//    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 66)];
//    headerView.backgroundColor = [UIColor orangeColor];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    self.tableView.tableHeaderView = searchBar;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.contentOffset = CGPointMake(0, -20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)refreshControlAction:(id)sender
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

- (void)addButtonAction:(id)sender
{
    [self.dataArray addObject:[[NSDate date] description]];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] ] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)removeButtonAction:(id)sender
{
    NSInteger random = (rand() % self.dataArray.count);
    [self.dataArray removeObjectAtIndex:random];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:random inSection:0] ] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.detailTextLabel.text = [indexPath description];
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@"http://rajce.hippotaps.com/tomato.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    });
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
}


@end
