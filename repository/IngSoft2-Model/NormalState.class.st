"
Represents the normal state of a square
"
Class {
	#name : 'NormalState',
	#superclass : 'SquareState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
NormalState >> applyEffectFrom: aSquare to: aShip in: aGame [

	aSquare applyNormalEffectTo: aShip in: aGame

]

{ #category : 'highlighting' }
NormalState >> reverse [ 

	^ ReversedState new
]
