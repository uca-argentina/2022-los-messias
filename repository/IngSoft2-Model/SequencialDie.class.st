Class {
	#name : #SequencialDie,
	#superclass : #Object,
	#instVars : [
		'numbers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequencialDie class >> with: aCollectionOfNumbers [ 
	^self new initializeWith: aCollectionOfNumbers.
]

{ #category : #initialization }
SequencialDie >> initializeWith: aCollectionOfNumbers [ 
	 numbers := aCollectionOfNumbers.
	
	
]

{ #category : #rolling }
SequencialDie >> roll [
	| result aNumber |
	result := numbers at: 1.
	aNumber := numbers removeFirst.
	numbers addLast: aNumber.
	^result
]
