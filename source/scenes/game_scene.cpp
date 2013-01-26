#include "game_scene.h"
#include "../gameflow.h"

enum
{
	kJobLoadScene
};

GameScene::GameScene(SceneNode *parent, Camera *mainCamera)
	: pPlayer(NULL)
	, pCamera(mainCamera)
	, pScene(parent)
	, musTheme()
{
}

GameScene::~GameScene()
{
}

bool GameScene::Initialize()
{
	gFlow->AddScene(pScene);
	pJobManager->Add(New(FileLoader("scenes/game.scene", kJobLoadScene, this)));
	return true;
}

bool GameScene::Update(f32 dt)
{
	UNUSED(dt)

	if (pPlayer)
	{
		pPlayer->SetPosition(0.0f, 0.0f, 0.0f);
	}

	return true;
}

bool GameScene::Shutdown()
{
	musTheme.Unload();

	gFlow->RemoveScene(pScene);
	pScene->Unload();
	pScene = NULL;

	pInput->RemoveKeyboardListener(this);

	return true;
}

void GameScene::OnInputKeyboardRelease(const EventInputKeyboard *ev)
{
	Key k = ev->GetKey();
}

void GameScene::OnJobCompleted(const EventJob *ev)
{
	switch (ev->GetName())
	{
		case kJobLoadScene:
		{
			FileLoader *job = (FileLoader *)ev->GetJob();
			Reader r(job->pFile);
			pScene->Load(r);
			Log("Scene Name: %s len %d", pScene->sName.c_str(), pScene->Size());
			Delete(job);

			musTheme.Load("sounds/theme.ogg");
			musTheme.SetVolume(1.0f);
			pSoundSystem->PlayMusic(&musTheme);

			pPlayer = (ISceneObject *)pScene->GetChildByName("Player");		
			pGameMap = (GameMap *)pScene->GetChildByName("Map");

			MapLayerMetadata *game = pGameMap->GetLayerByName("Game")->AsMetadata();

			for(unsigned i = 0, len = game->Size(); i < len; ++i)
			{
				IMetadataObject *placeHolder = static_cast<IMetadataObject *>( game->GetChildAt(i));
				const String &type = placeHolder->GetProperty("Type");

				if(type == "Entity")
				{
					clWorldManager.BuildEntity(*placeHolder);
				}
			}

			pPlayer = game->GetChildByName("Player");
		}
		break;
	}
}

void GameScene::OnJobAborted(const EventJob *ev)
{
	Job *job = ev->GetJob();
	Delete(job);
}
