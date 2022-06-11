Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyEffectTo: aShip removing: aCard in: aZathuraGame [

	aZathuraGame removeFromCardsOnTable: aCard of: aShip
]
