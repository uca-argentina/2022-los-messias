Class {
	#name : #HyperJump,
	#superclass : #Object,
	#instVars : [
		'sequenceParsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> with: aCollectionOfNumbers [
	^self new initializeWith: aCollectionOfNumbers
]

{ #category : #'instance creation' }
HyperJump >> action: aShip on: aBoard [

	aBoard
		move: aShip
		by: (self totalLockersFrom: (sequenceParsecs at: 1) In: aBoard).
	self changeNextParsec
]

{ #category : #sequencing }
HyperJump >> changeNextParsec [
	| aNumberOfParsecs  |
	aNumberOfParsecs  := sequenceParsecs removeFirst.
	sequenceParsecs addLast: aNumberOfParsecs.
]

{ #category : #initialization }
HyperJump >> initializeWith: aCollectionOfNumbers [

	sequenceParsecs := OrderedCollection new.
	aCollectionOfNumbers do: [ :aNumber | 
		sequenceParsecs add: aNumber ]
]

{ #category : #'instance creation' }
HyperJump >> totalLockersFrom: result In: aBoard [

	^ result
	  //
	  (aBoard boardStructure parsecs
	   / aBoard boardStructure lockers size)
]
