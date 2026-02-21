"
Implementation of a loaded die, that responds to the message: 'roll', and returns a pre defined number N.
"
Class {
	#name : 'LoadedDie',
	#superclass : 'Die',
	#instVars : [
		'index'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedDie class >> withSides: aNumberToBeRolled [

	^ self new initializeWith: aNumberToBeRolled
]

{ #category : 'initialization' }
LoadedDie >> initializeWith: aNumberToBeRolled [

	sideNumber := aNumberToBeRolled.
	index := 1
]

{ #category : 'random' }
LoadedDie >> roll [

	| numberInSequence |
	
	sideNumber isInteger ifTrue: [ ^ sideNumber ].

	numberInSequence := sideNumber at: index.
	index := index \\ sideNumber size + 1.
	^ numberInSequence
]
