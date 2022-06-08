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
	^ self new initializeWith: aCollection asOrderedCollection 
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
