"
Implementation of speed card effect, which gives the ship n extra square positions.
"
Class {
	#name : 'AdditionalSquares',
	#superclass : 'PermanentEffects',
	#instVars : [
		'numberOfSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'one more square' }
AdditionalSquares >> addMovement: aShip [
	
	^ self subclassResponsibility
	
]

{ #category : 'initialization' }
AdditionalSquares >> initializeOf: aNumber usedBy: aCard [
	
	numberOfSquares := aNumber.
	usedBy := aCard.
	
	^ self
]
