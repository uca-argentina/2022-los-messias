Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyEffectTo: aShip removing: aCard on: aCardManager [

	aCardManager removeFromCardsOnTable:
		(ActiveCard with: aCard appliedTo: aShip)
]
