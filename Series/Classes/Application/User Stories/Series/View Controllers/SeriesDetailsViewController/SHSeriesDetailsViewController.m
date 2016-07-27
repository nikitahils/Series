//
//  SHSeriesDetailsViewController.m
//  Shows
//
//  Created by iam on 25/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHSeriesDetailsViewController.h"
#import "UIImageView+Loading.h"
#import "SHSeriesRouter.h"
#import "SHStoryboardIdentifiers.h"
#import "SHSeriesDetailsViewModel.h"
#import "SHFavoritesManager.h"
#import "SHInfoTableViewCell.h"
#import "SHOverviewTableViewCell.h"
#import "SHFavoritesManager.h"
#import "Actor.h"
#import "Constants.h"
#import "Series.h"

static const NSInteger kOverviewSectionNumber = 0;
static const NSInteger kActorsSectionNumber   = 1;

@import SpinKit;
@import Masonry;

@interface SHSeriesDetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *sections;

@property (weak, nonatomic) IBOutlet UILabel *customTitle;

@property (nonatomic, strong) RTSpinKitView *spinner;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITableView *seriesDetailsTableView;

@end

@implementation SHSeriesDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupInterface];
}

- (void)setupInterface
{
    self.sections = @[NSLocalizedString(@"Overview", nil),
                      NSLocalizedString(@"Actors", nil)];
    
    BOOL isFavorite = [[SHFavoritesManager shared] isFavoriteWithSeriesIdentifier:self.seriesDetailsViewModel.series.identifier];
    
    self.favoriteButton.selected = isFavorite;
    self.favoriteButton.layer.shadowRadius = 3;
    self.favoriteButton.layer.shadowOffset = CGSizeMake(0, 3);
    self.favoriteButton.layer.shadowOpacity = 0.4;
    
    self.customTitle.layer.shadowRadius = 5;
    self.customTitle.layer.shadowOffset = CGSizeMake(0, 0);
    self.customTitle.layer.shadowOpacity = 0.7;
    
    @weakify(self);
    RAC(self.favoriteButton, enabled) = RACObserve(self.seriesDetailsViewModel, fetched);
    
    RACSignal *buttonPressedSignal = [self.favoriteButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    [buttonPressedSignal subscribeNext:^(UIButton *button) {
        @strongify(self);
        BOOL isFavorite = self.favoriteButton.selected;
        if (isFavorite) {
            BOOL isFavorite = [[SHFavoritesManager shared] isFavoriteWithSeriesIdentifier:self.seriesDetailsViewModel.series.identifier];
            if (isFavorite) {
                [[SHFavoritesManager shared] removeFromFavorites:self.seriesDetailsViewModel.series];
            } else {
                [[SHFavoritesManager shared] addToFavorites:self.seriesDetailsViewModel.series];
            }
        }
    }];
    
    buttonPressedSignal = [self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    [buttonPressedSignal subscribeNext:^(UIButton *button) {
        @strongify(self);
        [self.router dismissCurrentViewController:self
                                         animated:YES];
    }];
    
    self.seriesDetailsTableView.rowHeight = UITableViewAutomaticDimension;
    self.seriesDetailsTableView.estimatedRowHeight = 95.0;
    self.seriesDetailsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SHInfoTableViewCell class])
                                bundle:[NSBundle mainBundle]];
    [self.seriesDetailsTableView registerNib:nib
                      forCellReuseIdentifier:SHInfoTableViewCellIdentifier];
    nib = [UINib nibWithNibName:NSStringFromClass([SHOverviewTableViewCell class])
                         bundle:[NSBundle mainBundle]];
    [self.seriesDetailsTableView registerNib:nib
                      forCellReuseIdentifier:SHOverviewTableViewCellIdentifier];
    
    self.spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce];
    [self.posterImageView addSubview:self.spinner];
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.posterImageView);
    }];
    
    [RACObserve(self.seriesDetailsViewModel, isFetching) subscribeNext:^(NSNumber *isFetching) {
        @strongify(self);
        [self.spinner startAnimating];
        if (![isFetching boolValue]) {
            [self.posterImageView setImageWithURL:self.seriesDetailsViewModel.series.posterURL
                                              completion:^(BOOL sucess){
                                                  [self.spinner stopAnimating];
                                              }];
            self.customTitle.text = self.seriesDetailsViewModel.series.name;
            [self.seriesDetailsTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.seriesDetailsViewModel.isFetching) {
        return 0;
    }
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != kOverviewSectionNumber) {
        return self.seriesDetailsViewModel.series.actors.count;
    }
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.section) {
        case kOverviewSectionNumber:
        {
            SHOverviewTableViewCell *overviewCell = [tableView dequeueReusableCellWithIdentifier:SHOverviewTableViewCellIdentifier
                                                                                    forIndexPath:indexPath];
            NSString *overview = (self.seriesDetailsViewModel.series.overview)? self.seriesDetailsViewModel.series.overview
            : NSLocalizedString(@"No information provided", nil);
            [overviewCell configureWithText:overview
                                      color:[UIColor grayColor]];
            
            cell = overviewCell;
            break;
        }
        case kActorsSectionNumber:
        {
            SHInfoTableViewCell *actorCell = [tableView dequeueReusableCellWithIdentifier:SHInfoTableViewCellIdentifier
                                                                                forIndexPath:indexPath];
            Actor *actor = self.seriesDetailsViewModel.series.actors[indexPath.row];
            if (actor) {
                [actorCell configureWithImageURL:actor.imageURL
                                           title:actor.name
                                     description:actor.role];
            }
            cell = actorCell;
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    header.contentView.backgroundColor = RGB(187, 203, 227);
}

@end
