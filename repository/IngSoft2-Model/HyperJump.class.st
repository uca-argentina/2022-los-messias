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

	| result |
	result := sequenceParsecs at: 1.
	self changeNextParsec.
	aBoard move: aShip by: (result // aBoard size ).
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
	aCollectionOfNumbers do: [ :aNumber | sequenceParsecs add: aNumber]

]
