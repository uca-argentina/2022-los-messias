Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyEffectTo: ship on: aCardManager by: sourceShip [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard applyEffectTo: ship on: aCardManager by: sourceShip.
	aCardManager throw: aCard
]

{ #category : #action }
RedoCard >> applyEffectTo: ship removing: card in: zathuraGame [

	| aCard |
	aCard := zathuraGame lastCardThrownOnTheGame.
	aCard applyEffectTo: ship removing: card in: zathuraGame.
	zathuraGame throw: aCard
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsOn: aCardManager by: sourceShip [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard applyEffectToAllShipsOn: aCardManager by: sourceShip.
	aCardManager throw: aCard
]
