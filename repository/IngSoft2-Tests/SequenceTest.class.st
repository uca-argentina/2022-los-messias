Class {
	#name : #SequenceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceTest >> testTheRotationOfTheSequenceWorksCorrectly [

	| aSequence |
	aSequence := Sequence with: { 1 . 2 . 3}.

	self assert: aSequence next equals: 1.
	self assert: aSequence next equals: 2.
	self assert: aSequence next equals: 3.
	self assert: aSequence next equals: 1
]
