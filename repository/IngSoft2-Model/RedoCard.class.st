Class {
	#name : #RedoCard,
	#superclass : #Card,
	#instVars : [
		'cardRepeated'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
RedoCard >> accept: aCardManager [

	self fetchCardToRedoFrom: aCardManager.
	^ cardRepeated accept: aCardManager
]

{ #category : #accessing }
RedoCard >> cardRepeated [
	^cardRepeated 
]

{ #category : #action }
RedoCard >> fetchCardToRedoFrom: aCardManager [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	( aCard isMemberOf: self class ) ifTrue:  [ 
		aCard := aCard cardRepeated ].
	cardRepeated := aCard
]
