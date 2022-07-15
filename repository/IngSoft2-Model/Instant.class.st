Class {
	#name : #Instant,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Instant >> applyEffectOf: activeCard on: aCardManager [

	aCardManager addCardToTable: activeCard
]
