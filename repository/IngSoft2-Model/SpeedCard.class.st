Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyEffectTo: ship on: aCardManager by: sourceShip [

	self assertIsYourTurn: sourceShip in: aCardManager.
	
	aCardManager addCardToTable:
		(ActiveCard with: self appliedTo: { ship }).
	
	aCardManager addToTheCardsStack: self
]

{ #category : #action }
SpeedCard >> assertIsYourTurn: aShip in: aCardManager [

	(aCardManager isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]
