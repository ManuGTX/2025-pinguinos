"
HyperSpaceJump in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
HyperSpaceJump >> applyEffectTo: aShip in: aGame [

	isReversed
		ifFalse: [
			aGame moveAndIgnoreNewEffectsShip: aShip by: 4.
			aShip loseShield ]
		ifTrue: [
			aGame moveAndIgnoreNewEffectsAllShipsBy: 4 exceptFor: aShip.
			aGame breakShieldsOfAllShipsExceptFor: aShip ]
]

{ #category : 'testing' }
HyperSpaceJump >> isSpecial [

	^ true
]
