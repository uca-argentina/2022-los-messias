Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyEffectRemoving: aCard in: aZathuraGame [

	aZathuraGame removeFromCardsOnTable: aCard
]
