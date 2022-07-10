Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> accept: aCardManager [

	^[ :aCard :aShip | 
	aCardManager removeFromCardsOnTable:
		(ActiveCard with: aCard appliedTo: aShip) ]
]
