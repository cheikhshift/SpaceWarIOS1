//
//  levelTransition.m
//  Starship I
//
//  Created by user on 6/18/14.
//  Copyright (c) 2014 My World Entertainment LLC. All rights reserved.
//

#import "levelTransition.h"
#import "levelTwo.h"
#import "levelthree.h"
#import "levelfour.h"
#import "levelfive.h"
#import "levelsix.h"
#import "levelseven.h"
#import "leveleight.h"
#import "levelnine.h"
#import "levelten.h"
#import "cosmosMyScene.h"

static const float OBJECT_VELOCITY = 280.0;



static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}

@implementation levelTransition {
    NSInteger _whichLevel;
    SKSpriteNode *ship;
    NSInteger _importedScore;
}

-(id)initWithSize:(CGSize)size score: (NSInteger)player_score next:(NSInteger) which_level caption:(NSString *) text {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        _importedScore = player_score;
        
        NSString * message;
        message = @"Level Cleared";
        _whichLevel = which_level;
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor whiteColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        NSString * retrymessage;
      
        SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
        retryButton.fontColor = [SKColor whiteColor];
        retryButton.position = CGPointMake(self.size.width/2, 50);
        retryButton.name = @"retry";
        [retryButton setScale:.5];

        if(which_level == 10){
              retrymessage = @"You finished the game, replay?";
             retryButton.text = retrymessage;
            _whichLevel = 0;
        }
        else {
              retrymessage = @"Start next level";
             retryButton.text = retrymessage;
      
        }
              [self addChild:retryButton];
    
        
        
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
        
        
        ship = [SKSpriteNode spriteNodeWithImageNamed:@"main ship 1.png"];
        [ship setScale:0.47];
        ship.zRotation = - M_PI / 2;
        
        //Adding SpriteKit physicsBody for collision detection
    
        ship.name = @"ship";
        ship.position = CGPointMake(45,180);
        [self addChild:ship];
        
        
        
        
        
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
        
        else  if(_whichLevel == 0){
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
 
}


@end
