Class {
	#name : #SequenceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceTest >> testSequenceThrowsErrorWhenInitializedWithAnEmptyCollection [

	self
		should: [ Sequence with:  {  } ]
		raise: Error
		withMessage:
		'Sequence should not be loaded with an empty Collection'
]

{ #category : #tests }
SequenceTest >> testTheRotationOfTheSequenceWorksCorrectly [

	| aCollection aSequence |
	aCollection := OrderedCollection with: 1 with: 2 with: 3.
	aSequence := Sequence with: aCollection.

	self assert: aSequence value equals: 1.
	aSequence next.
	self assert: aSequence value equals: 2.
	aSequence next.
	self assert: aSequence value equals: 3.
	aSequence next.
	self assert: aSequence value equals: 1
]
