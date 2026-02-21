"
Implementation of speed card effect, which gives the ship n extra square positions.
"
Class {
	#name : 'AdditionalSquares',
	#superclass : 'PermanentEffects',
	#instVars : [
		'applyToEveryone',
		'targetShip',
		'numberOfSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
AdditionalSquares class >> of: aNumber to: aTargetShip usedBy: aCard [

	^ self new initializeOf: aNumber with: aTargetShip usedBy: aCard
]

{ #category : 'creation' }
AdditionalSquares class >> of: aNumber toAnyUsedBy: aCard [

	^ self new initializeOf: aNumber toAnyUsedBy: aCard
]

{ #category : 'one more square' }
AdditionalSquares >> addMovement: aShip [

	^ (applyToEveryone or: targetShip name = aShip name)
		  ifTrue: [ numberOfSquares ]
		  ifFalse: [ 0 ]
]

{ #category : 'initialization' }
AdditionalSquares >> initializeOf: aNumber toAnyUsedBy: aCard [
	
	numberOfSquares := aNumber.
	applyToEveryone := true.
	targetShip := NullShip new.
	usedBy := aCard.
	^ self
]

{ #category : 'initialization' }
AdditionalSquares >> initializeOf: aNumber with: aTargetShip usedBy: aCard [
	
	numberOfSquares := aNumber.
	applyToEveryone := false.
	targetShip := aTargetShip.
	usedBy := aCard.
	^ self
]
