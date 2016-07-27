//
//  SHUpdatesViewController.m
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHUpdatesViewController.h"
#import "SHSeriesRouter.h"
#import "SHStoryboardIdentifiers.h"
#import "Series.h"
#import "SHSeriesUpdatesViewModel.h"
#import "SHSeriesDetailsViewModel.h"
#import "SHPageCollectionViewCell.h"
#import "SHPageCollectionView.h"
#import "SHUserManager.h"

@interface SHUpdatesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoritesBarButtonItem;
@property (weak, nonatomic) IBOutlet SHPageCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutBarButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *startActivityIndicator;

@end

@implementation SHUpdatesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupInterface];
}

- (void)setupInterface
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SHPageCollectionViewCell class])
                                bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:SHPageCollectionViewCellIdentifier];
    
    @weakify(self);
    self.logoutBarButtonItem.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [[SHUserManager shared] logout];
        [self.router showAuthViewControllerFromSourceController:self];
        return [RACSignal empty];
    }];
    
    self.favoritesBarButtonItem.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.router showFavoritesViewControllerFromSourceController:self];
        return [RACSignal empty];
    }];
    
    [RACObserve(self.seriesUpdatesViewModel, fetched) subscribeNext:^(NSNumber *fetched) {
        @strongify(self);
        if ([fetched boolValue]) {
            [UIView animateWithDuration:0.5f animations:^{
                self.collectionView.alpha = 1.0f;
                self.pageLabel.alpha = 1.0f;
                self.pageLabel.text = [NSString stringWithFormat:@"1/%zd",
                                       self.seriesUpdatesViewModel.seriesDetailsViewModels.count];
            }];
            
            [self.startActivityIndicator stopAnimating];
            
            [self.collectionView reloadData];
        }
    }];
    
    [self.seriesUpdatesViewModel fetch];
}

#pragma mark - Collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.seriesUpdatesViewModel.seriesDetailsViewModels.count;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHSeriesDetailsViewModel *model = self.seriesUpdatesViewModel.seriesDetailsViewModels[indexPath.row];
    [model fetch];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    SHSeriesDetailsViewModel *model = self.seriesUpdatesViewModel.seriesDetailsViewModels[indexPath.row];
    [model stop];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SHPageCollectionViewCellIdentifier
                                                                               forIndexPath:indexPath];
    [cell configureWith:self.seriesUpdatesViewModel.seriesDetailsViewModels[indexPath.row]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.collectionView.currentIndex + 1,
                           self.seriesUpdatesViewModel.seriesDetailsViewModels.count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.collectionView.currentIndex) {
        [self.router showSeriesDetailsViewControllerFromSourceController:self
                                                                   model:self.seriesUpdatesViewModel.seriesDetailsViewModels[indexPath.row]];
    }
}

@end