"
Implementation of HyperJump special square.
"
Class {
	#name : 'HyperJump',
	#superclass : 'Square',
	#instVars : [
		'parsecList',
		'parsecListSize',
		'currentIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperJump class >> at: aPosition [

	^ self new initializeAt: aPosition
]

{ #category : 'action' }
HyperJump >> applyEffectTo: aShip in: aGame [

	aGame hyperJump: aShip byParsecs: self parsecsToMove
]

{ #category : 'initialization' }
HyperJump >> initializeAt: position [

	parsecList := OrderedCollection new.
	parsecListSize := 5.
	currentIndex := 1.

	super initializeAtPosition: position.

	1 to: parsecListSize do: [ :i | parsecList add: i + 1 ]
]

{ #category : 'testing' }
HyperJump >> isSpecial [

	^ true
]

{ #category : 'accessing' }
HyperJump >> parsecsToMove [

	| returnValue |
	
	returnValue := parsecList at: currentIndex.
	currentIndex := currentIndex \\ parsecListSize + 1.

	^ returnValue
]
