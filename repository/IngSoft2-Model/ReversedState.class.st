"
Represents the reversed polarity state of a square
"
Class {
	#name : 'ReversedState',
	#superclass : 'SquareState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
ReversedState >> applyEffectFrom: aSquare to: aShip in: aGame [

	aSquare applyReverseEffectTo: aShip in: aGame
]

{ #category : 'highlighting' }
ReversedState >> reverse [ 

	^ NormalState new
]
