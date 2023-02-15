Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyEffectToAllShipsOn: aCardManager by: sourceShip [

	self assertIsYourTurn: sourceShip in: aCardManager.
	
	aCardManager addCardToTable:
		(ActiveCard with: self appliedTo: aCardManager ships).
	
	aCardManager addToTheCardsStack: self
]

{ #category : #asserting }
AccelerationCard >> assertIsYourTurn: aShip in: aCardManager [

	(aCardManager isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #accesing }
AccelerationCard >> changeOfRoll [
	^1
]
