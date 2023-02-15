Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyEffectTo: aShip on: aCardManager by: sourceShip [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard applyEffectTo: aShip on: aCardManager by: sourceShip.

	aCardManager addToTheCardsStack: aCard
]

{ #category : #action }
RedoCard >> applyEffectTo: aShip removing: card on: aCardManager [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard applyEffectTo: aShip removing: card on: aCardManager.

	aCardManager addToTheCardsStack: aCard
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsOn: aCardManager by: sourceShip [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard applyEffectToAllShipsOn: aCardManager by: sourceShip.
	
	aCardManager addToTheCardsStack: aCard
]
