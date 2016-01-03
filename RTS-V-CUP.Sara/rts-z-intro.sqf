Sleep .001;
Player SetDir 0;

Null = [] ExecVM "sound\RTS_Music.sqf";

_cam = "camera" camCreate [1000,1000,0];
_cam cameraEffect ["internal","back"];
_cam camSetTarget [1000,1000,5];
_cam camSetFOV 0.700;
_cam CamSetRelPos [-10,1,0];
_cam camCommit 0;

2 FadeSound 1;

Null = [] ExecVM "sound\RTS_Music.sqf";
TitleRsc ["Title2","Plain"];
_cam camCommit 5;

disableUserInput TRUE;

WaitUntil {camCommitted _Cam;};

cutText ["","Plain Down",4];
titleText ["For instructions, click -RTS Menu- on your action list, then click HELP.","Black Faded",1];
Sleep 5;

titleText ["Initializing Deployment Orders...","Black Faded",1];

player switchCamera "INTERNAL";
player cameraEffect ["terminate","back"];
camDestroy _cam;
Sleep 5;

// [] exec "rts-z-intro.sqs";

titleText ["","White In", 2];

disableUserInput FALSE;
Player EnableSimulation True;
call RTS_Intro_Titletext_Code;


//[Player] exec "Karr-DLG-Loadout.sqs"
