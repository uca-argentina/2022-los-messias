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

	cardRepeated := aCardManager lastCardThrownOnTheGame.
	cardRepeated applyEffectTo: aShip on: aCardManager by: sourceShip
]

{ #category : #action }
RedoCard >> applyEffectTo: aShip removing: card on: aCardManager [

	cardRepeated := aCardManager lastCardThrownOnTheGame.
	cardRepeated applyEffectTo: aShip removing: card on: aCardManager
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsOn: aCardManager by: sourceShip [

	cardRepeated := aCardManager lastCardThrownOnTheGame.
	cardRepeated applyEffectToAllShipsOn: aCardManager by: sourceShip
]
