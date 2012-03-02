#import "cocos2d.h"
#import "RigidBody.h"
#import "Physics.h"
#import "Vector3.h"

@interface HelloWorldLayer : CCLayerColor  <UIAccelerometerDelegate>
{
}

+(CCScene *) scene;
-(void)configureAccelerometer;
-(void)updatePhysics: (ccTime)dt;
-(void)drawRigidBodies;
-(void)drawMap;

@property (nonatomic, retain) CCSprite* playerA;
@property (nonatomic, retain) CCSprite* playerB;
@property (nonatomic, retain) RigidBody* rigidBodyA;
@property (nonatomic, retain) RigidBody* rigidBodyB;
@property (nonatomic, retain) Map* map;
@property (nonatomic, retain) Vector3* accelerometer;

@end
