"
Implementation of speed card, from the permanent type of cards.
"
Class {
	#name : 'SpeedCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
SpeedCard >> isRepeatable [

	^ true
]

{ #category : 'testing' }
SpeedCard >> isTurnRestricted [

	^ true
]

{ #category : 'action handling' }
SpeedCard >> managedBy: aCardManager from: anActivatorShip target: aTargetShip [

	aCardManager addEffect:
		(AdditionalSquares of: 1 to: aTargetShip usedBy: self)
]
