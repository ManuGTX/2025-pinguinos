"
Blackhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'BlackHole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
BlackHole >> applyEffectTo: aShip in: aGame [

	isReversed
		ifFalse: [ aGame moveAndIgnoreNewEffectsShip: aShip by: -4 ]
		ifTrue: [ aGame moveAndIgnoreNewEffectsAllShipsBy: -4 exceptFor: aShip ]
]

{ #category : 'testing' }
BlackHole >> isSpecial [

	^ true
]
