//
//  cosmosPAUSE.m
//  Starship I
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 My World Entertainment LLC. All rights reserved.
//

#import "cosmosPAUSE.h"
#import "cosmosMyScene.h"
#import "SurvivalModeOne.h"
#import "levelTwo.h"
#import "levelthree.h"
#import "levelfour.h"
#import "levelfive.h"
#import "levelsix.h"
#import "levelseven.h"
#import "leveleight.h"
#import "levelnine.h"
#import "levelten.h"
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


@implementation cosmosPAUSE {
    NSInteger _whichLevel;
    NSInteger _importedScore;
    NSDictionary *survlevels;
}

-(id)initWithSize:(CGSize)size score: (NSInteger)player_score ifreplay:(NSInteger) which_level{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        _importedScore = 0;
        NSString * message;
        message = @"Game Over";
        _whichLevel = which_level;
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor whiteColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
          survlevels = @{@"k1": @0, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1, @"k": @1};
       
        
        if(which_level == 11){
        NSString * retrymessage;
        retrymessage = @"Play Story mode";
        SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
        retryButton.text = retrymessage;
        retryButton.fontColor = [SKColor whiteColor];
        retryButton.position = CGPointMake(self.size.width/2, 50);
        retryButton.name = @"retry";
        [retryButton setScale:.5];
        
        [self addChild:retryButton];
        
        NSString * survival;
        survival = @"Can you survive some more?";
        SKLabelNode *replayButton = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
        replayButton.text = survival;
        replayButton.fontColor = [SKColor whiteColor];
        replayButton.position = CGPointMake(self.size.width/2, 100);
        replayButton.name = @"replay";
        [replayButton setScale:.5];
        
        [self addChild:replayButton];
        }
        else {
            NSString * retrymessage;
            retrymessage = @"Replay level";
            SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
            retryButton.text = retrymessage;
            retryButton.fontColor = [SKColor whiteColor];
            retryButton.position = CGPointMake(self.size.width/2, 50);
            retryButton.name = @"retry";
            [retryButton setScale:.5];
            
            [self addChild:retryButton];
            
            NSString * survival;
            survival = @"Play Survival";
            SKLabelNode *replayButton = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
            replayButton.text = survival;
            replayButton.fontColor = [SKColor whiteColor];
            replayButton.position = CGPointMake(self.size.width/2, 100);
            replayButton.name = @"replay";
            [replayButton setScale:.5];
            
            [self addChild:replayButton];
        }
        
        
        NSString * playerscoremsg = [NSString stringWithFormat:@"Player Score: %ld",(long)player_score];
        
        SKLabelNode *playerscore = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        playerscore.text = playerscoremsg;
        playerscore.fontColor = [SKColor whiteColor];
        playerscore.position = CGPointMake(self.size.width/2, 250);
        playerscore.name = @"Player Score";
        [playerscore setScale:.5];
        
        [self addChild:playerscore];
        
        //UIDevice * currentDevice = [UIDevice currentDevice];
        //NSString *deviceIDString = [currentDevice.identifierForVendor UUIDString]; //getting unique id for the user
        
        
      //  NSNumber *playerScoreNum = [NSNumber numberWithInt:player_score]; //converting score into NSNumber format in which Parse expect the score
        
     
    
        
        
    
        
        
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"retry"]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        
        if(_whichLevel == 1){
            levelTwo * scene = [[levelTwo alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        
        else  if(_whichLevel == 0 || _whichLevel == 11){
            cosmosMyScene * scene = [[cosmosMyScene alloc] initWithSize:self.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        
        else  if(_whichLevel == 2){
            levelthree * scene = [[levelthree alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        
        else  if(_whichLevel == 3){
            levelfour * scene = [[levelfour alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        else  if(_whichLevel == 4){
            levelfive * scene = [[levelfive alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        else  if(_whichLevel == 5){
            levelsix * scene = [[levelsix alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        else  if(_whichLevel == 6){
            levelseven * scene = [[levelseven alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        else  if(_whichLevel == 7){
            leveleight * scene = [[leveleight alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        else  if(_whichLevel == 8){
            levelnine * scene = [[levelnine alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        else  if(_whichLevel == 9){
            levelten * scene = [[levelten alloc] initWithSize:self.size score:(NSInteger)_importedScore];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition: reveal];
            
        }
        
    
        
        
        
    }
    else if ([node.name isEqualToString:@"replay"]) {
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
}


@end
