"
Implementation of CardGiver special square.
"
Class {
	#name : 'CardGiver',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CardGiver class >> at: aPosition [

	^self new initializeAt: aPosition
]

{ #category : 'action' }
CardGiver >> applyEffectTo: aShip in: aGame [

	isReversed
		ifFalse: [ aGame drawCardFor: aShip ]
		ifTrue: [ aGame drawCardsForEveryoneExceptFor: aShip ]
]

{ #category : 'testing' }
CardGiver >> isSpecial [

	^ true
]
