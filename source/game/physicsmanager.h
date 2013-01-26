#ifndef PHYSICSMANAGER_H
#define PHYSICSMANAGER_H

#include "../defines.h"
#include <Box2D/Box2D.h>

class PhysicsManager
{
	public:
		PhysicsManager();
		~PhysicsManager();

		void Update(f32 dt);
		void CreateBody(ISceneObject *obj);
		void CreateStaticBody(ISceneObject *obj);

	private:
		void ClearWorld();

	private:
		b2World *pWorld;

};

#endif // PHYSICSMANAGER_H