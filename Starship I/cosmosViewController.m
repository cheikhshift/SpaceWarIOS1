//
//  cosmosViewController.m
//  Starship I
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 My World Entertainment LLC. All rights reserved.
//

#import "cosmosViewController.h"
#import "cosmosMyScene.h"
#import "SurvivalModeOne.h"
#import "smtwo.h"
#import "smthree.h"
#import "smfour.h"
#import "smfive.h"
#import "smsix.h"
#import "smseven.h"
#import "smeight.h"
#import "smnine.h"
#import "smten.h"

@implementation cosmosViewController {
    NSDictionary *survlevels;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    survlevels = @{@"k1": @0, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1};
   
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad unit ID.
   bannerView_.adUnitID = @"ca-app-pub-9560280336099846/4956009613";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
   bannerView_.rootViewController = self;
   [self.view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
    bannerView_.center = CGPointMake(160, 50);
    
  }

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


-(void) hidpeepz {
   // _newgame.hidden = YES;
    //_setsu.hidden = YES;
    //_surv.hidden = YES;
    _surv.hidden = YES;
    _bgj.hidden = YES;
    bannerView_.hidden = YES;
}
-(IBAction)pauseGame:(id)sender {
    
}

- (IBAction)survival:(id)sender {
    //SurvivalModeOne
    [self hidpeepz];
    NSArray *array = [survlevels allKeys];
    int random = arc4random()%[array count];
    SKView * skView = (SKView *)self.view;
    SKScene * scene;
    if(random == 0){
        scene = [SurvivalModeOne sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 1){
        scene = [smtwo sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 2){
        scene = [smthree sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 3){
        scene = [smfour sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 4){
        scene = [smfive sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 5){
        scene = [smsix sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 6){
        scene = [smseven sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 7){
        scene = [smeight sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 8){
        scene = [smnine sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    else if (random == 9){
        scene = [smten sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
    }
    
    [skView presentScene:scene];
    
}

- (IBAction)startgame:(id)sender {
    
    [self hidpeepz];
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    SKScene * scene = [cosmosMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
}


@end
