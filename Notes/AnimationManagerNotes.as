﻿AnimationMananger is going to be a class like FormManager	-a globally accessible array of all the animations	-Its reason for exsistence is to be the the Animation and its subclasses event Manager Essentially	-Examples:		-The class CharacterAnimation extends Animation			CharacterAnimation is a container for all the character Animations				-Member Funcs					-beginAnimations(p_anim:String):void					-abortCurrentAnimation():String  returns string of CurrentAnimation					-pauseCurrentAnimation():String	 reutrns string of CurrentAnimation						Note: On the linkage between an Animation and the code that may use it, the link will be a string just like event Links				-Member Properties					-Variable for each of the animations						-class SkillAnimation extends Animation							-This class Throws events relevent to the BattlesScreen								-When the attack should display floating Numbers/ When the gui should be updated						-class BattleIdleAnimation extends Animation							-This class Throws events relevent to the AnimationManager								-For Example when its at the End of its loop so the transistion to the SkillAnimation is Fluid					CharacterAnimation Will Rethrow all these Events to the Animation Manager or Skill/BattleIdle will Directly access the AnimationManager						-Note: AnimationManager is going to be a constant through all projects so this might not be a bad idea					