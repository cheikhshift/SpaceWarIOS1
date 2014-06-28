//
//  cosmosViewController.h
//  starship
//

//  Copyright (c) 2014 My World Entertainment LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GADBannerView.h"

@interface cosmosViewController : UIViewController {
     GADBannerView *bannerView_;
}


@property (weak, nonatomic) IBOutlet UIView *surv;
@property (weak, nonatomic) IBOutlet UIImageView *bgj;

@property (weak, nonatomic) IBOutlet UIButton *pausk;

@property (strong, nonatomic) SKScene *mainSc;
-(IBAction)startgame:(id)sender;
-(IBAction)pauseGame:(id)sender;
- (IBAction)survival:(id)sender;
@end
