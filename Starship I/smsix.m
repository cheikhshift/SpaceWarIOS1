//
//  SurvivalModeOne.m
//  Starship I
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 My World Entertainment LLC. All rights reserved.
//

#import "smsix.h"
#import "cosmosPAUSE.h"

static const uint32_t shipCategory =  0x1 << 0;
static const uint32_t obstacleCategory =  0x1 << 1;
static const uint32_t ennemyShip =  0x2 << 1;
static const uint32_t playerLaser =  0x8 << 0;

static const float BG_VELOCITY = 100.0;
static const float OBJECT_VELOCITY = 280.0;
static const float LASER_VELOCITY = 375.0;


static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}


@implementation smsix {
    
    SKSpriteNode *ship;
    
    SKAction *actionMoveUp;
    SKAction *actionMoveDown;
    
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    NSTimeInterval _lastMissileAdded;
    NSInteger _lastAttack;
    NSInteger _fileinter;
    NSInteger _currentRendered;
    NSDictionary *ennemyfleet;
    NSDictionary *movement;
    NSDictionary *movey, *coinpossib;
    NSInteger _playerScore;
    NSInteger _playerlife;
    NSInteger _killedoff;
    NSInteger _wave;
    
}
float oldY;
BOOL dragging;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"background 5.png"];
        
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        
        [self addChild:sn];
        [self initalizingScrollingBackground:@"Planet 5.png"];
        [self addShip];
        _lastAttack = 0;
        _fileinter = 0;
        _wave = 1;
        _currentRendered = 0;
        _playerScore = 0;
        _playerlife = 50;
        _killedoff = 0;
        ennemyfleet = @{ @"k1" : @"planet 5 destroyers.png", @"k2" : @"planet 5 captains.png", @"k3" : @"planet 5 guards.png" };
        movement = @{ @"k1" : @1, @"k2" : @2, @"k3" : @3 , @"k4": @4 , @"k5": @4, @"k6": @0,@"k7": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4,@"k8": @4	};
        movey = @{ @"k1" : @2, @"k2" : @30, @"k3" : @20 , @"k4": @0 , @"k5": @1 , @"k6": @18, @"k7": @0, @"k8": @6, @"k9": @7, @"k10": @4, @"k11": @0, @"k12": @12, @"k13": @14, @"k14": @12, @"k15": @21, @"k16": @27, @"k17": @0, @"k18": @14, @"k19": @19, @"k20": @0, @"k21": @8, @"k22": @1, @"k23": @4, @"k24": @19, @"k26": @26, @"k25": @25, @"k26": @12, @"k27": @6, @"k28": @0, @"k29": @2, @"k30": @1, @"k31": @1, @"k32": @1, @"k33": @1};
        //[NSDictionary dictionaryWithObjectsAndKeys:
        //@"planet 10 destroyers.png", @"planet 10 captains.png", @"planet 10 guards.png", nil];
        
        coinpossib = @{@"P": @0, @"N": @1};
        
        NSString * message;
        message = [NSString stringWithFormat:@"WAVE %i", _wave];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
        label.text = message;
        label.name = @"wave";
        label.fontSize = 40;
        label.fontColor = [SKColor whiteColor];
        label.position = CGPointMake(self.size.width + 50, self.size.height/2);
        [self addChild:label];
        
    }
    return self;
}

-(void)initalizingScrollingBackground:(NSString *) withName
{
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:withName];
        bg.position = CGPointMake(i * bg.size.width, 0);
        bg.anchorPoint = CGPointZero;
        bg.name = @"bg";
        [self addChild:bg];
        
    }
    
}

-(void)updateScore:(int *) mode tovalue:(int *) amount {
    
}


-(void)shoot:(NSString *) graphic withSprite:(SKSpriteNode *) spot {
    
    SKSpriteNode *missile;
    missile = [SKSpriteNode spriteNodeWithImageNamed:graphic];
    [missile setScale:0.03];
    
    //Adding SpriteKit physicsBody for collision detection
    missile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile.size];
    missile.physicsBody.categoryBitMask = playerLaser;
    missile.physicsBody.dynamic = YES;
    missile.physicsBody.contactTestBitMask = ennemyShip;
    missile.physicsBody.collisionBitMask = 0;
    missile.physicsBody.usesPreciseCollisionDetection = YES;
    missile.name = @"LASER";
    
    //selecting random y position for missile
    
    missile.position = CGPointMake(spot.position.x + spot.frame.size.width / 2, spot.position.y);
    
    [self addChild:missile];
    //load laser and send down
}



-(void)ennemshoot:(NSString *) graphic withSprite:(SKSpriteNode *) spot {
    
    SKSpriteNode *missile;
    missile = [SKSpriteNode spriteNodeWithImageNamed:graphic];
    [missile setScale:0.03];
    
    //Adding SpriteKit physicsBody for collision detection
    missile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile.size];
    missile.physicsBody.categoryBitMask = obstacleCategory;
    missile.physicsBody.dynamic = YES;
    missile.physicsBody.contactTestBitMask = shipCategory;
    missile.physicsBody.collisionBitMask = 0;
    missile.physicsBody.usesPreciseCollisionDetection = YES;
    missile.name = @"LASERENNEMY";
    
    //selecting random y position for missile
    
    missile.position = CGPointMake(spot.position.x - spot.frame.size.width / 2, spot.position.y);
    
    [self addChild:missile];
    //load laser and send down
}

-(void)addShip
{
    //initalizing spaceship node
    ship = [SKSpriteNode spriteNodeWithImageNamed:@"main ship 1.png"];
    [ship setScale:0.47];
    ship.zRotation = - M_PI / 2;
    
    //Adding SpriteKit physicsBody for collision detection
    ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.size];
    ship.physicsBody.categoryBitMask = shipCategory;
    ship.physicsBody.dynamic = YES;
    ship.physicsBody.contactTestBitMask = obstacleCategory;
    ship.physicsBody.collisionBitMask = 0;
    ship.physicsBody.usesPreciseCollisionDetection = YES;
    ship.name = @"ship";
    ship.position = CGPointMake(45,180);
    actionMoveUp = [SKAction moveByX:0 y:30 duration:.2];
    actionMoveDown = [SKAction moveByX:0 y:-30 duration:.2];
    
    SKSpriteNode *pause = [SKSpriteNode spriteNodeWithImageNamed:@"pause menu.png"];
    pause.position = CGPointMake(self.frame.size.width - 20, self.frame.size.height - 25);
    pause.name = @"PAUSE";
    pause.color = [SKColor whiteColor];
    [pause setScale:0.6];
    [self addChild:pause];
    
    SKLabelNode *health = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    health.position = CGPointMake(60, self.frame.size.height - 35);
    health.name = @"HEALTH";
    health.text = @"HEALTH";
    health.color = [SKColor whiteColor];
    [health setScale:0.6];
    [self addChild:health];
    NSString * retrymessage;
    retrymessage = @"shoot";
    SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    retryButton.text = retrymessage;
    retryButton.fontColor = [SKColor whiteColor];
    retryButton.position = CGPointMake(self.frame.size.width - 50, 22);
    retryButton.name = @"shoot";
    [retryButton setScale:0.8];
    [self addChild:retryButton];
    
    SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    score.text = @"Score :";
    score.fontColor = [SKColor whiteColor];
    score.position = CGPointMake(75, 10);
    score.name = @"score";
    [score setScale:0.6];
    [self addChild:score];
    
    
    
    
    [self addChild:ship];
}

- (void)moveBg
{
    [self enumerateChildNodesWithName:@"bg" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         SKSpriteNode * bg = (SKSpriteNode *) node;
         CGPoint bgVelocity = CGPointMake(-BG_VELOCITY, 0);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity,_dt);
         bg.position = CGPointAdd(bg.position, amtToMove);
         
         //Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
         if (bg.position.x <= -bg.size.width)
         {
             bg.position = CGPointMake(bg.position.x + bg.size.width*2,
                                       bg.position.y);
         }
     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    /*if(touchLocation.y >ship.position.y){
     if(ship.position.y < 270){
     [ship runAction:actionMoveUp];
     }
     }else{
     if(ship.position.y > 50){
     
     [ship runAction:actionMoveDown];
     }
     
     } */
    // NSLog(@"%f", touchLocation.y);
    
    SKNode *node = [self nodeAtPoint:touchLocation];
    //NSLog(@"%f", node.position.y);
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"shoot"]) {
        //do whatever...
        [self shoot:@"Red_laser.png" withSprite:ship];
    }
    if ([node.name isEqualToString:@"PAUSE"]) {
        //do whatever...
        if(self.view.scene.paused){
            self.view.scene.paused = NO;
        }
        else {
            self.view.scene.paused = YES;
        }
    }
    
    oldY = touchLocation.y;
    dragging = YES;
    
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(dragging){
        
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self.scene];
        if(touchLocation.x > self.frame.size.width / 2 + 20){
            [self shoot:@"Red_laser.png" withSprite:ship];
        }
        else {
            // NSLog(@"%f", touchLocation.y);
            ship.position = CGPointMake(45,touchLocation.y);
        }
    }
}

-(void)addObstacle:(NSString *) withName
{
    //initalizing spaceship node
    SKSpriteNode *missile;
    missile = [SKSpriteNode spriteNodeWithImageNamed:withName];
    [missile setScale:0.16];
    missile.zRotation = - M_PI / 2;
    //Adding SpriteKit physicsBody for collision detection
    missile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile.size];
    missile.physicsBody.categoryBitMask = obstacleCategory;
    missile.physicsBody.dynamic = YES;
    missile.physicsBody.contactTestBitMask = shipCategory;
    missile.physicsBody.collisionBitMask = 0;
    missile.physicsBody.usesPreciseCollisionDetection = YES;
    missile.name = @"missile";
    
    //selecting random y position for missile
    int r = arc4random() % 300;
    missile.position = CGPointMake(self.frame.size.width + 20,r);
    
    [self addChild:missile];
    
    
    NSArray *array = [coinpossib allKeys];
    int random = arc4random()%[array count];
    
    if(random == 1){
        SKSpriteNode *coin = [SKSpriteNode spriteNodeWithImageNamed:@"Coin-icon.png"];
        [coin setScale:0.09];
        coin.zRotation =  M_PI / 2;
        //Adding SpriteKit physicsBody for collision detection
        coin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:coin.size];
        coin.physicsBody.categoryBitMask = obstacleCategory;
        coin.physicsBody.dynamic = YES;
        coin.physicsBody.contactTestBitMask = shipCategory;
        coin.physicsBody.collisionBitMask = 0;
        coin.physicsBody.usesPreciseCollisionDetection = YES;
        coin.name = @"coin";
        
        //selecting random y position for missile
        int r = arc4random() % 300;
        coin.position = CGPointMake(self.frame.size.width + 20,r);
        
        
        [self addChild:coin];
    }
    
}

-(void)addSpecial:(NSString *) withName
{
    //initalizing spaceship node
    SKSpriteNode *missile;
    missile = [SKSpriteNode spriteNodeWithImageNamed:withName];
    [missile setScale:0.24];
    missile.zRotation =  M_PI / 2;
    //Adding SpriteKit physicsBody for collision detection
    missile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile.size];
    missile.physicsBody.categoryBitMask = ennemyShip;
    missile.physicsBody.dynamic = YES;
    missile.physicsBody.contactTestBitMask = playerLaser;
    missile.physicsBody.collisionBitMask = 0;
    missile.physicsBody.usesPreciseCollisionDetection = YES;
    missile.name = @"special";
    
    //selecting random y position for missile
    int r = arc4random() % 300;
    missile.position = CGPointMake(self.frame.size.width + 20,r);
    
    [self addChild:missile];
    SKAction *align;
    if ([withName isEqualToString:@"planet 5 destroyers.png"]) {
        align = [SKAction moveByX:-90 y:0 duration:1.4];
        _playerScore = _playerScore + 25;
    }
    else if ([withName isEqualToString:@"planet 5 captains.png"]){
        align = [SKAction moveByX:-150 y:0 duration:1.4];
        _playerScore = _playerScore + 15;
    }
    else {
        align = [SKAction moveByX:-200 y:0 duration:1.4];
        _playerScore = _playerScore + 5;
    }
    
    
    [missile runAction:align];
    
}


- (void)moveObstacle
{
    NSArray *nodes = self.children;//1
    for(SKNode * node in nodes){
        if([node.name isEqualToString:@"LASER"]){
            SKSpriteNode *ob = (SKSpriteNode *) node;
            CGPoint obVelocity = CGPointMake(LASER_VELOCITY, 0);
            CGPoint amtToMove = CGPointMultiplyScalar(obVelocity,_dt);
            
            ob.position = CGPointAdd(ob.position, amtToMove);
            
            if(ob.position.x > self.frame.size.width + 20)
            {
                [ob removeFromParent];
            }
            
        }
        else if ([node.name isEqualToString:@"LASERENNEMY"]){
            
            SKSpriteNode *ob = (SKSpriteNode *) node;
            CGPoint obVelocity = CGPointMake(-LASER_VELOCITY, 0);
            CGPoint amtToMove = CGPointMultiplyScalar(obVelocity,_dt);
            
            ob.position = CGPointAdd(ob.position, amtToMove);
            
            if(ob.position.x > self.frame.size.width - 80)
            {
                [ob removeFromParent];
            }
            
            
        }
        else if ([node.name isEqualToString:@"score"]){
            //update score based on latest number
            
        }
        else if ([node.name isEqualToString:@"PAUSE"]){
            //update score based on latest number
            
        }
        else if ([node.name isEqualToString:@"HEALTH"]){
            //update score based on latest number
            
            SKLabelNode *ob = (SKLabelNode *) node;
            if(_playerlife > 40){
                ob.fontColor = [UIColor whiteColor];
            }
            else if(_playerlife > 30){
                ob.fontColor = [UIColor yellowColor];
            }
            
            else if(_playerlife > 20){
                ob.fontColor = [UIColor orangeColor];
            }
            else {
                ob.fontColor = [UIColor redColor];
            }
            
        }
        
        else if ( ![node.name  isEqual: @"shoot"] &&  ![node.name  isEqual: @"bg"] && ![node.name  isEqual: @"ship"] && ![node.name isEqualToString:@"BACKGROUND"]) {
            if([node.name isEqualToString:@"special"]){
                NSArray *array = [movement allKeys];
                int random = arc4random()%[array count];
                
                NSArray *arrays = [movey allKeys];
                int randoms = arc4random()%[arrays count];
                NSString *key = [arrays objectAtIndex:randoms];
                SKAction *moveup = [SKAction moveByX:0 y:[movey[key] integerValue] duration:1.3];
                SKAction *movedown = [SKAction moveByX:0 y:-[movey[key] integerValue] duration:1.3];
                
                SKSpriteNode *ob = (SKSpriteNode *) node;
                //NSLog(@"%@", movey[key]);
                
                
                if(ob.position.y > 0 && ob.position.y < self.frame.size.height){
                    switch (random) {
                        case 3:
                            [ob runAction:moveup];
                            break;
                            
                        case 0:
                            [ob runAction:movedown];
                            break;
                        case 5:
                            [self ennemshoot:@"greenLaserRay.png" withSprite:ob];
                            break;
                            
                        case 2:
                            [self ennemshoot:@"greenLaserRay.png" withSprite:ob];
                            
                            break;
                            
                            
                        case 9:
                            [self ennemshoot:@"greenLaserRay.png" withSprite:ob];
                            
                            break;
                            
                            
                        default:
                            
                            break;
                    }
                }
                else if (ob.position.y > self.frame.size.height){
                    SKAction *movein = [SKAction moveByX:0 y:-25 duration:1.3];
                    [ob runAction:movein];
                }
                else {
                    SKAction *movein = [SKAction moveByX:0 y:25 duration:1.3];
                    [ob runAction:movein];
                }
                
            }
            
            
            else {
                SKSpriteNode *ob = (SKSpriteNode *) node;
                CGPoint obVelocity = CGPointMake(-OBJECT_VELOCITY, 0);
                CGPoint amtToMove = CGPointMultiplyScalar(obVelocity,_dt);
                
                ob.position = CGPointAdd(ob.position, amtToMove);
                
                if(ob.position.x < -100)
                {
                    [ob removeFromParent];
                }
            }
            
            
            
        }
    }
    
    
}



-(void) addboss {
    
    //next level
    
    
}


-(void)update:(CFTimeInterval)currentTime {
    
    
    if (self.paused == NO ) {
        
        [self enumerateChildNodesWithName:@"score" usingBlock:^(SKNode *node, BOOL *stop) {
            /* block of code below runs if a character is found */
            
            SKLabelNode* character = (SKLabelNode*) node;
            
            character.text = [NSString stringWithFormat:@"Score: %d", _playerScore];
            
        }];
        
        
        
        if (_lastUpdateTime)
        {
            _dt = currentTime - _lastUpdateTime;
        }
        else
        {
            _dt = 0;
        }
        _lastUpdateTime = currentTime;
        
        //mini obstacles
        if( currentTime - _lastMissileAdded > 1)
        {
            _lastMissileAdded = currentTime + 1;
            [self addObstacle:@"planet 5 soldiers.png"];
            _playerScore = _playerScore + 1;
            _lastAttack = _lastAttack + 1;
            
            if(_currentRendered < 5){
                if(_lastAttack == 5){
                    NSArray *array = [ennemyfleet allKeys];
                    int random = arc4random()%[array count];
                    NSString *key = [array objectAtIndex:random];
                    if(key != nil)[self addSpecial:ennemyfleet[key]];
                    
                    _lastAttack = 0;
                    //_currentRendered = _currentRendered + 1;
                }
            }
            if(_currentRendered == 5){
                //load boss
                //NSLog(@"boss");
                
                _currentRendered = _currentRendered + 1;
            }
            
        }
        
        
        
        
        [self moveBg];
        [self moveObstacle];
    }
    
}



- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    
    
    if ((firstBody.categoryBitMask & shipCategory) != 0 &&
        (secondBody.categoryBitMask & obstacleCategory) != 0)
    {
        //[ship removeFromParent];
        //SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        // SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size score:player_score];
        //[self.view presentScene:gameOverScene transition: reveal];
        if(_playerlife > 0){
            
            
            SKNode *nodeB = secondBody.node;
            
            SKSpriteNode *TG = (SKSpriteNode *) nodeB;
            TG.texture = [SKTexture textureWithImageNamed:@"misc_explosion_element_png_by_dbszabo1-d54iy0g.png"];
            if([TG.name isEqualToString:@"LASERENNEMY"]){
                [TG removeFromParent];
                _playerlife = _playerlife - 1;
                
            }
            else if([TG.name isEqualToString:@"BOOM"]){
                
                
            }
            else if([TG.name isEqualToString:@"coin"]){
                [TG removeFromParent];
                _playerScore = _playerScore + 10;
                
            }
            
            
            else {
                _playerlife = _playerlife - 5;
            }
            
        }
        else {
            self.view.scene.paused = YES;
            [ship removeFromParent];
            
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            SKScene * gameOverScene = [[cosmosPAUSE alloc] initWithSize:self.size score:_playerScore ifreplay:11];//11 means survival :D
            [self.view presentScene:gameOverScene transition: reveal];
            
        }
        //NSLog(@"%i", _playerlife);
        
        
    }
    
    else
    {
        //[ship removeFromParent];
        //SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        // SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size score:player_score];
        //[self.view presentScene:gameOverScene transition: reveal];
        
        SKNode *nodeA = firstBody.node;
        SKNode *nodeb = secondBody.node;
        [nodeb removeFromParent];
        SKSpriteNode *TG = (SKSpriteNode *) nodeA;
        
        TG.texture = [SKTexture textureWithImageNamed:@"misc_explosion_element_png_by_dbszabo1-d54iy0g.png"];
        
        if([TG.name isEqualToString:@"special"]){
            _playerScore = _playerScore + 10;
            _killedoff = _killedoff + 1;
            TG.name = @"BOOM";
            if(_killedoff > (_wave*5)){
                _currentRendered = 0;
                _killedoff = 0;
                
                _wave = _wave + 1;_playerlife = _playerlife + 15;
                
                
                NSString * message;
                message = [NSString stringWithFormat:@"WAVE %i", _wave];
                
                SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
                label.text = message;
                label.name = @"wave";
                label.fontSize = 40;
                label.fontColor = [SKColor whiteColor];
                label.position = CGPointMake(self.size.width + 50, self.size.height/2);
                [self addChild:label];
            }
        }
        
    }
    
}

@end
