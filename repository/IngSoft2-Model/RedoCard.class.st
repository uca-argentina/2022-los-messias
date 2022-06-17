Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyEffectTo: ship in: zathuraGame by: sourceShip [

	| aCard |
	aCard := zathuraGame lastCardThrownOnTheGame.
	aCard applyEffectTo: ship in: zathuraGame by: sourceShip 
]

{ #category : #action }
RedoCard >> applyEffectTo: ship removing: card in: zathuraGame [

	| aCard |
	aCard := zathuraGame lastCardThrownOnTheGame card.
	aCard applyEffectTo: ship  removing: card in: zathuraGame 
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsIn: aZathuraGame by: sourceShip [

	| aCard |
	aCard := aZathuraGame lastCardThrownOnTheGame card.
	aCard applyEffectToAllShipsIn: aZathuraGame by: sourceShip 
]
