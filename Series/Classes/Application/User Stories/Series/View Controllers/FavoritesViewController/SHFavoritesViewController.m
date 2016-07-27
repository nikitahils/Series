//
//  SHFavoritesViewController.m
//  Shows
//
//  Created by iam on 25/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHFavoritesViewController.h"
#import "SHFavoritesTableViewCell.h"
#import "SHFavoritesManager.h"
#import "SHSeriesRouter.h"
#import "SHStoryboardIdentifiers.h"
#import "Series.h"

@interface SHFavoritesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITableView *favoritesTableView;
@property (nonatomic, strong) NSArray<Series*> *series;

@end

@implementation SHFavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupInterface];
}

- (void)setupInterface
{
    self.series = [SHFavoritesManager shared].series;
    
    @weakify(self);
    RACSignal *buttonPressedSignal = [self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    [buttonPressedSignal subscribeNext:^(UIButton *button) {
        @strongify(self);
        [self.router dismissCurrentViewController:self
                                         animated:YES];
    }];
    
    self.favoritesTableView.rowHeight = UITableViewAutomaticDimension;
    self.favoritesTableView.estimatedRowHeight = 93.0;
    self.favoritesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SHFavoritesTableViewCell class])
                                bundle:[NSBundle mainBundle]];
    [self.favoritesTableView registerNib:nib
                  forCellReuseIdentifier:SHFavoritesTableViewCellIdentifier];
    [self.favoritesTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.series.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHFavoritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHFavoritesTableViewCellIdentifier
                                                                     forIndexPath:indexPath];
    Series *series = self.series[indexPath.row];
    [cell configureWithImageURL:series.posterURL
                          title:series.name];
    return cell;
}

@end
