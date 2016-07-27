//
//  SHInfoTableViewCell.h
//  Shows
//
//  Created by iam on 26/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@interface SHInfoTableViewCell : UITableViewCell

- (void)configureWithImageURL:(NSURL *)url
                        title:(NSString *)title
                  description:(NSString *)description;

@end
