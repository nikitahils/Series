//
//  UIViewController+Routing.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@protocol SHRouter;

typedef void (^SHPreparationBlock)(UIStoryboardSegue *segue);

@interface UIViewController (Routing)

@property (nonatomic, strong) id <SHRouter> router;

- (void)performSegueWithIdentifier:(NSString *)identifier
                            sender:(id)sender
                  preparationBlock:(SHPreparationBlock)block;

- (SHPreparationBlock)preparationBlockForSegue:(UIStoryboardSegue *)segue;

@end

@protocol SHRouter <NSObject>

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
