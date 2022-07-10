Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'cardRepeated'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyEffectTo: aShip on: aCardManager by: sourceShip [

	self fetchCardToRedoFrom: aCardManager.
	cardRepeated applyEffectTo: aShip on: aCardManager by: sourceShip
]

{ #category : #action }
RedoCard >> applyEffectTo: aShip removing: card on: aCardManager [

	self fetchCardToRedoFrom: aCardManager.
	cardRepeated applyEffectTo: aShip removing: card on: aCardManager
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsOn: aCardManager by: sourceShip [

	self fetchCardToRedoFrom: aCardManager.
	cardRepeated applyEffectToAllShipsOn: aCardManager by: sourceShip
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
