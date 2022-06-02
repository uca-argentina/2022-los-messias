Class {
	#name : #Sequence,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Sequence class >> assertValid: aCollection [

	aCollection size <= 0 ifTrue: [ 
		Error signal:
			'Sequence should not be loaded with an empty Collection' ]
]

{ #category : #'instance creation' }
Sequence class >> with: aCollection [

	| newOrderedCollection |
	self assertValid: aCollection.
	newOrderedCollection := OrderedCollection new.
	1 to: aCollection size do: [ :i | 
	newOrderedCollection add: (aCollection at: i) ].
	^ self new initializeWith: newOrderedCollection
]

{ #category : #accessing }
Sequence >> collection [

	^collection 
]

{ #category : #initialization }
Sequence >> initializeWith: aCollection [ 
	collection := aCollection 
]

{ #category : #'change set' }
Sequence >> next [
	| aValue |
	aValue := collection removeFirst.
	collection addLast: aValue
]

{ #category : #accessing }
Sequence >> value [

	^ collection at: 1
]
