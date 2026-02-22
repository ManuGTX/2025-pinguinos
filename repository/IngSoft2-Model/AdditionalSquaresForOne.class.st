"
AdditionalSquares effect that applies to one ship

"
Class {
	#name : 'AdditionalSquaresForOne',
	#superclass : 'AdditionalSquares',
	#instVars : [
		'targetShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
AdditionalSquaresForOne class >> of: aNumber to: aTargetShip usedBy: aCard [

	^ self new initializeOf: aNumber usedBy: aCard withTarget: aTargetShip 
]

{ #category : 'one more square' }
AdditionalSquaresForOne >> addMovement: aShip [

	targetShip = aShip ifFalse: [ ^ 0 ].

	isReversed
		ifFalse: [ ^ numberOfSquares ]
		ifTrue: [ ^ numberOfSquares negated ]
]

{ #category : 'initialization' }
AdditionalSquaresForOne >> initializeOf: aNumber usedBy: aCard withTarget: aTargetShip [
	
	super initializeOf: aNumber usedBy: aCard.
	targetShip := aTargetShip.
	
	
]
