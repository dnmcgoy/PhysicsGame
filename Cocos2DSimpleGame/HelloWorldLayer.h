#import "cocos2d.h"
#import "RigidBody.h"
#import "Physics.h"

@interface HelloWorldLayer : CCLayerColor
{
}

+(CCScene *) scene;
-(void)updatePhysics: (ccTime)dt;
-(void)drawRigidBodies;

@property (nonatomic, retain) CCSprite* player;
@property (nonatomic, retain) RigidBody* rigidBody;

@end
