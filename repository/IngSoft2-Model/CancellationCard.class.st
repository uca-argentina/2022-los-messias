Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyEffectTo: aShip removing: aCard in: zathuraGame [

	zathuraGame removeFromCardsOnTable:
		(ActiveCard with: aCard appliedTo: { aShip }).
		
	zathuraGame throw: self
]

{ #category : #action }
CancellationCard >> applyEffectToAllShipsRemoving: aCard in: aZathuraGame [

	aZathuraGame removeFromCardsOnTable:
		(ActiveCard with: aCard appliedTo: aZathuraGame ships).
		
aZathuraGame throw: self.
]
