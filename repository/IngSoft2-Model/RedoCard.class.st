Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyEffectTo: ship in: zathuraGame [

	| aCard |
	aCard := zathuraGame lastCardThrewOnTable.
	aCard applyEffectTo: ship in: zathuraGame
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsIn: aZathuraGame [

	| aCard |
	aCard := aZathuraGame lastCardThrewOnTable.
	aCard applyEffectToAllShipsIn: aZathuraGame
]
