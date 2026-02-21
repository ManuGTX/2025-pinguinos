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

	^ self new initializeOf: aNumber with: aTargetShip usedBy: aCard toAll: false
]

{ #category : 'creation' }
AdditionalSquares class >> of: aNumber toAnyUsedBy: aCard [

	^ self new
		  initializeOf: aNumber
		  with: NullShip new
		  usedBy: aCard
		  toAll: true
]

{ #category : 'one more square' }
AdditionalSquares >> addMovement: aShip [

	^ (applyToEveryone or: targetShip name = aShip name)
		  ifTrue: [ numberOfSquares ]
		  ifFalse: [ 0 ]
]

{ #category : 'initialization' }
AdditionalSquares >> initializeOf: aNumber with: aTargetShip usedBy: aCard toAll: aBoolean [
	
	numberOfSquares := aNumber.
	applyToEveryone := aBoolean.
	targetShip := aTargetShip.
	usedBy := aCard.
	^ self
]
