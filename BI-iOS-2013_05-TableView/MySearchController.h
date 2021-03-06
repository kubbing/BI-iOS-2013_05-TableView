//
//  MySearchController.h
//  BI-iOS-2013_05-TableView
//
//  Created by Jakub Hladík on 21.10.13.
//  Copyright (c) 2013 Flowknight s.r.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySearchController : UISearchDisplayController <UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *filteredArray;

@end
