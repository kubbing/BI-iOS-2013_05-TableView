//
//  FirstViewController.m
//  BI-iOS-2013_05-TableView
//
//  Created by Jakub Hladík on 21.10.13.
//  Copyright (c) 2013 Flowknight s.r.o. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation FirstViewController

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
    
    self.view.backgroundColor = [UIColor redColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
