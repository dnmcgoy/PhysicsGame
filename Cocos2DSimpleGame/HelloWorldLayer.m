#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

@synthesize rigidBodyA;
@synthesize rigidBodyB;
@synthesize playerA;
@synthesize playerB;
@synthesize map;
@synthesize accelerometer;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

-(void)configureAccelerometer
{
    UIAccelerometer* accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/60.0f;       
}

- (void)accelerometer:(UIAccelerometer*)accel
        didAccelerate:(UIAcceleration*)acceleration 
{    
    accelerometer.x =  acceleration.x;
    accelerometer.y =  acceleration.y;
    accelerometer.z =  acceleration.z;
}

-(void) addTileAtX:(int)x
                 Y:(int)y
          withWall:(Wall*)wall 
{
    [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:x 
                                                                         andY:y] 
                                          withWall:wall]];
}

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] ))
    {
        accelerometer = [[Vector3 alloc] init];
        [self configureAccelerometer];
        
        self.playerA = [CCSprite spriteWithFile:@"football.png" 
                                          rect:CGRectMake(0, 0, 48, 48)];
        self.playerB = [CCSprite spriteWithFile:@"football.png" 
                                           rect:CGRectMake(0, 0, 48, 48)];
        [self addChild:self.playerA];
        [self addChild:self.playerB];
        
        NSMutableArray* boundingBox = [[NSMutableArray alloc] init];
        [boundingBox addObject:[[Vector2 alloc] initWithX:-5 andY:-100]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:-5 andY:30]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:5 andY:30]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:5 andY:-100]];
        /*[boundingBox addObject:[[Vector2 alloc] initWithX:-20 andY:-22]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:-20 andY:5]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:0 andY:22]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:20 andY:23]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:20 andY:0]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:0 andY:-20]];*/
        
        self.rigidBodyA = [[RigidBody alloc] initWithBoundingBox:boundingBox
                                                     andPosition:[[Vector2 alloc] initWithX:220
                                                                                       andY:200]];
        
        self.rigidBodyB = [[RigidBody alloc] initWithBoundingBox:boundingBox
                                                     andPosition:[[Vector2 alloc] initWithX:120
                                                                                       andY:200]];
        
        [self.rigidBodyA updatePoints];
        [self.rigidBodyA storePreviousPoints];
        self.rigidBodyA.velocity.x = 200;
        self.rigidBodyA.velocity.y = 200;
        self.rigidBodyA.hasGravity = YES;
        self.playerA.position = ccp(self.rigidBodyA.position.x, self.rigidBodyA.position.y);
        
        [self.rigidBodyB updatePoints];
        [self.rigidBodyB storePreviousPoints];
        self.rigidBodyB.velocity.x = 200;
        self.rigidBodyB.velocity.y = 200;
        self.rigidBodyB.hasGravity = YES;
        self.playerB.position = ccp(self.rigidBodyB.position.x, self.rigidBodyB.position.y);
        
        self.map = [[Map alloc] init];
        
        Wall* bottomWall = [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:0 andY:1] andPointB:[[Vector2 alloc] initWithX:1 andY:1]];
        Wall* rightWall =  [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:0 andY:0] andPointB:[[Vector2 alloc] initWithX:0 andY:1]];
        Wall* topWall =    [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:1 andY:0] andPointB:[[Vector2 alloc] initWithX:0 andY:0]];
        Wall* leftWall =   [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:1 andY:1] andPointB:[[Vector2 alloc] initWithX:1 andY:0]];
        
        [self addTileAtX:0 Y:-1 withWall:bottomWall];
        [self addTileAtX:1 Y:-1 withWall:bottomWall];
        [self addTileAtX:2 Y:-1 withWall:bottomWall];
        [self addTileAtX:3 Y:-1 withWall:bottomWall];
        [self addTileAtX:4 Y:-1 withWall:bottomWall];
        [self addTileAtX:5 Y:-1 withWall:bottomWall];
        [self addTileAtX:6 Y:-1 withWall:bottomWall];
        [self addTileAtX:7 Y:-1 withWall:bottomWall];
        [self addTileAtX:8 Y:-1 withWall:bottomWall];
        [self addTileAtX:9 Y:-1 withWall:bottomWall];
        [self addTileAtX:10 Y:-1 withWall:bottomWall];
        [self addTileAtX:11 Y:-1 withWall:bottomWall];
        
        [self addTileAtX:12 Y:0 withWall:rightWall];
        [self addTileAtX:12 Y:1 withWall:rightWall];
        [self addTileAtX:12 Y:2 withWall:rightWall];
        [self addTileAtX:12 Y:3 withWall:rightWall];
        [self addTileAtX:12 Y:4 withWall:rightWall];
        [self addTileAtX:12 Y:5 withWall:rightWall];
        [self addTileAtX:12 Y:6 withWall:rightWall];
        [self addTileAtX:12 Y:7 withWall:rightWall];
        
        [self addTileAtX:11 Y:8 withWall:topWall];
        [self addTileAtX:10 Y:8 withWall:topWall];
        [self addTileAtX:9 Y:8 withWall:topWall];
        [self addTileAtX:8 Y:8 withWall:topWall];
        [self addTileAtX:7 Y:8 withWall:topWall];
        [self addTileAtX:6 Y:8 withWall:topWall];
        [self addTileAtX:5 Y:8 withWall:topWall];
        [self addTileAtX:4 Y:8 withWall:topWall];
        [self addTileAtX:3 Y:8 withWall:topWall];
        [self addTileAtX:2 Y:8 withWall:topWall];
        [self addTileAtX:1 Y:8 withWall:topWall];
        [self addTileAtX:0 Y:8 withWall:topWall];
        
        [self addTileAtX:-1 Y:7 withWall:leftWall];
        [self addTileAtX:-1 Y:6 withWall:leftWall];
        [self addTileAtX:-1 Y:5 withWall:leftWall];
        [self addTileAtX:-1 Y:4 withWall:leftWall];
        [self addTileAtX:-1 Y:3 withWall:leftWall];
        [self addTileAtX:-1 Y:2 withWall:leftWall];
        [self addTileAtX:-1 Y:1 withWall:leftWall];
        [self addTileAtX:-1 Y:0 withWall:leftWall];
    }
    
    [self schedule:@selector(gameLoop:) interval:0.01666667];
    self.isTouchEnabled = YES;
    
    return self;
}

-(void)gameLoop:(ccTime)dt 
{
    [self updatePhysics: dt];
}

-(void)updatePhysics:(ccTime)dt
{
    [self.rigidBodyA storePreviousPoints];
    [self.rigidBodyB storePreviousPoints];
    
    [Physics updateGravityOfRigidBody:self.rigidBodyA 
                    withAccelerometer:accelerometer
                        overTimeDelta:dt];
    
    [Physics updateVelocityOfRigidBody:self.rigidBodyA overTimeDelta:dt];
    [Physics updatePositionOfRigidBody:self.rigidBodyA overTimeDelta:dt];
    [Physics updateRotationOfRigidBody:self.rigidBodyA overTimeDelta:dt];
    [self.rigidBodyA updatePoints];
    
    [Physics updateGravityOfRigidBody:self.rigidBodyB 
                    withAccelerometer:accelerometer
                        overTimeDelta:dt];
    
    [Physics updateVelocityOfRigidBody:self.rigidBodyB overTimeDelta:dt];
    [Physics updatePositionOfRigidBody:self.rigidBodyB overTimeDelta:dt];
    [Physics updateRotationOfRigidBody:self.rigidBodyB overTimeDelta:dt];
    [self.rigidBodyB updatePoints];
    
    //[Physics correctCollisionsBetweenRigidBodyA:rigidBodyA andRigidBodyB:rigidBodyB overTimeDelta:dt];
    [self.rigidBodyA updatePoints];
    [self.rigidBodyB updatePoints];
    
    [Physics correctCollisionsBetweenMap:self.map andRigidBody:self.rigidBodyA overTimeDelta:dt];
    [self.rigidBodyA updatePoints];
    
    [Physics correctCollisionsBetweenMap:self.map andRigidBody:self.rigidBodyB overTimeDelta:dt];
    [self.rigidBodyB updatePoints];
}

-(void)draw
{
    self.playerA.position = ccp(self.rigidBodyA.position.x, self.rigidBodyA.position.y);
    self.playerA.rotation = self.rigidBodyA.rotation * -1;
    
    self.playerB.position = ccp(self.rigidBodyB.position.x, self.rigidBodyB.position.y);
    self.playerB.rotation = self.rigidBodyB.rotation * -1;
    
    [self drawRigidBodies];
    [self drawMap];
}

-(void)drawRigidBodies
{
    for(int i = 0; i < [self.rigidBodyA.points count]; i++)
	{
        Vector2* pointA = [self.rigidBodyA.points objectAtIndex:i];
        Vector2* pointB = nil;
        
		if(i < [self.rigidBodyA.points count] - 1)
		{
			pointB = [self.rigidBodyA.points objectAtIndex:i + 1];
		}
		else 
		{
            pointB = [self.rigidBodyA.points objectAtIndex:0];
		}
        
        glColor4f(1.0, 0.0, 0.0, 1.0);
        glLineWidth(1.0f);
        ccDrawLine(ccp(pointA.x, pointA.y), ccp(pointB.x, pointB.y));
    }
    
    for(int i = 0; i < [self.rigidBodyB.points count]; i++)
	{
        Vector2* pointA = [self.rigidBodyB.points objectAtIndex:i];
        Vector2* pointB = nil;
        
		if(i < [self.rigidBodyB.points count] - 1)
		{
			pointB = [self.rigidBodyB.points objectAtIndex:i + 1];
		}
		else 
		{
            pointB = [self.rigidBodyB.points objectAtIndex:0];
		}
        
        glColor4f(1.0, 0.0, 0.0, 1.0);
        glLineWidth(1.0f);
        ccDrawLine(ccp(pointA.x, pointA.y), ccp(pointB.x, pointB.y));
    }
}

-(void)drawMap
{
    for(int i = 0; i < [self.map.tiles count]; i++)
    {
        Tile* tile = [self.map.tiles objectAtIndex:i];
        Wall* absoluteWall = [tile getWallWithAbsolutePosition];
        Vector2* pointA = absoluteWall.w1;
        Vector2* pointB = absoluteWall.w2;
        
        glColor4f(0.0, 1.0, 0.0, 1.0);
        glLineWidth(1.0f);
        ccDrawLine(ccp(pointA.x, pointA.y), ccp(pointB.x, pointB.y));
    }
}

-(void)dealloc
{
	[super dealloc];
}

@end
