Class {
	#name : #HyperJumpEffect,
	#superclass : #Locker,
	#instVars : [
		'parsecsSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertSequenceIsValid: parsecSequence [

	parsecSequence isEmpty ifTrue: [ 
		Error signal: 'Hyperjump cannot have a null parsec sequence' ].

	(parsecSequence anySatisfy: [ :parsec | parsec <= 0 ]) ifTrue: [ 
		Error signal: 'Hyperjump cannot have less than zero parsecs in the sequence' ]
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecSequence [
	
	self assertSequenceIsValid: parsecSequence.
	^ self new initializeWith: parsecSequence 
]

{ #category : #'instance creation' }
HyperJumpEffect >> applyFor: aShip on: aBoard [

	| parsecs |
	parsecs := parsecsSequence removeFirst.
	aBoard move: aShip byParsecs: parsecs.
	parsecsSequence addLast: parsecs
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfNumbers [

	parsecsSequence := OrderedCollection new.
	aCollectionOfNumbers do: [ :aNumber | 
		parsecsSequence add: aNumber ]
]
