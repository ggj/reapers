#include "PlayerEntity.h"

#include "EntityFactory.h"

#include <SceneNode.h>
#include <LeakReport.h>
#include <Sprite.h>

#include "../gameflow.h"

ENTITY_CREATOR("Player", PlayerEntity);

PlayerEntity::PlayerEntity():
	pSprite(NULL)
{
	//empty
}

PlayerEntity::~PlayerEntity()
{
	Delete(pSprite);
}

void PlayerEntity::Load(Seed::IMetadataObject &metadata, Seed::SceneNode *sprites)
{
	//FIXME
	pSprite = New(Sprite(*static_cast<Sprite *>(sprites->GetChildByName("Player"))));
	gFlow->AddScene(pSprite);
}