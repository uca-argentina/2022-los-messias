Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyEffectToACard: anOverloadCard in: aZathuraGame [ 
	aZathuraGame removeFromCardsOnTable: anOverloadCard
]
