Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RedoCard >> = aCard [

^(self class == aCard class).
]

{ #category : #action }
RedoCard >> applyEffectTo: aShip on: aZathuraGame by: sourceShip [

	| aCard |
	aCard := aZathuraGame lastCardThrownOnTheGame.
	aCard applyEffectTo: aShip on: aZathuraGame by: sourceShip
]

{ #category : #action }
RedoCard >> applyEffectTo: aShip removing: card on: aZathuraGame [

	| aCard |
	aCard := aZathuraGame lastCardThrownOnTheGame.
	aCard applyEffectTo: aShip removing: card on: aZathuraGame
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsOn: zathura by: sourceShip [

	| aCard |
	aCard := zathura lastCardThrownOnTheGame.
	aCard applyEffectToAllShipsOn: zathura by: sourceShip
]
