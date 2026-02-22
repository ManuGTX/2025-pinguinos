"
Implementation of various permanent card effects, which will be stored for using in a turn.
"
Class {
	#name : 'PermanentEffects',
	#superclass : 'Object',
	#instVars : [
		'usedBy',
		'isReversed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'one more square' }
PermanentEffects >> addMovement: aShip [

	^ 0
]

{ #category : 'getter' }
PermanentEffects >> getAllyOf: aShip [
	
	^ nil
]

{ #category : 'getter' }
PermanentEffects >> getCardThatAppliedEffect [

	^ usedBy 
]

{ #category : 'getter' }
PermanentEffects >> getContractedMercenary [
	
	^ nil
]

{ #category : 'initialization' }
PermanentEffects >> initialize [

	super initialize.
	isReversed := false
]

{ #category : 'action' }
PermanentEffects >> reverseEffect [

	isReversed := isReversed not.
	
]
