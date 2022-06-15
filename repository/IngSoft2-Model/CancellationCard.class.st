Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> applyEffectTo: aShip removing: aCard in: zathuraGame [

	(aShip = '') ifTrue: [ zathuraGame removeFromCardsOnTable: (ActiveCard with: aCard appliedTo: (zathuraGame ships))] ifFalse: [ zathuraGame removeFromCardsOnTable: (ActiveCard with: aCard appliedTo: {aShip})].
]

{ #category : #action }
CancellationCard >> applyEffectToAllShipsRemoving: aCard in: aZathuraGame [

	aZathuraGame removeFromCardsOnTable: aCard
]
