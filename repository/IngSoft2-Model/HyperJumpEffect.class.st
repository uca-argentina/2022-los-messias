Class {
	#name : #HyperJumpEffect,
	#superclass : #Locker,
	#instVars : [
		'sequenceParsecs'
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

	aBoard
		move: aShip
		by: (self totalLockersFrom: (sequenceParsecs at: 1) in: aBoard).
	self changeNextParsec
]

{ #category : #private }
HyperJumpEffect >> changeNextParsec [
	| aNumberOfParsecs  |
	aNumberOfParsecs  := sequenceParsecs removeFirst.
	sequenceParsecs addLast: aNumberOfParsecs.
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfNumbers [

	sequenceParsecs := OrderedCollection new.
	aCollectionOfNumbers do: [ :aNumber | 
		sequenceParsecs add: aNumber ]
]

{ #category : #'instance creation' }
HyperJumpEffect >> totalLockersFrom: result in: aBoard [

	^ (result * aBoard parsecsPerLocker) asInteger 
]
