Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'cardRemoved'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> applyEffectTo: aShip removing: aCard in: zathuraGame [
	
	zathuraGame removeFromCardsOnTable:
		(ActiveCard with: aCard appliedTo: { aShip }).
	cardRemoved := aCard.
]

{ #category : #action }
CancellationCard >> applyEffectToAllShipsRemoving: aCard in: aZathuraGame [

	cardRemoved := aCard.
	aZathuraGame removeFromCardsOnTable:
		(ActiveCard with: aCard appliedTo: aZathuraGame ships)
]

{ #category : #accesing }
CancellationCard >> cardRemoved [
	^ cardRemoved
]
