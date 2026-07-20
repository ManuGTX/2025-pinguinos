Class {
	#name : 'StateTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
StateTest >> testReversingANormalStateCorrectlyCreatesAReversedState [

	| normalState |
	normalState := NormalState new.

	self assert: normalState reverse class identicalTo: ReversedState
]

{ #category : 'tests' }
StateTest >> testReversingAReversedStateCorrectlyCreatesANormalState [

	| reversedState |
	reversedState := ReversedState new.

	self assert: reversedState reverse class identicalTo: NormalState
]
