Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyEffectTo: aShip on: aCardManager by: sourceShip [

	
	self assertIsYourTurn: sourceShip in: aCardManager.
	
	aCardManager addCardToTable:
		(ActiveCard with: self appliedTo: { aShip }).
		
	aCardManager addToTheCardsStack: self.
]

{ #category : #action }
OverloadCard >> assertIsYourTurn: aShip in: aCardManager [

	(aCardManager isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]
