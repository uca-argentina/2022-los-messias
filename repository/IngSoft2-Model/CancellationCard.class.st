Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CancellationCard >> = aCard [

^(self class == aCard class).
]

{ #category : #action }
CancellationCard >> applyEffectTo: aShip removing: aCard on: aZathuraGame [

	aZathuraGame
		removeFromCardsOnTable: (ActiveCard with: aCard appliedTo: aShip)
		with: self
]
