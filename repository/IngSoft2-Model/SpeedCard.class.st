Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SpeedCard >> = aCard [

^(self class == aCard class)
]

{ #category : #action }
SpeedCard >> applyEffectTo: ship on: aZathuraGame by: sourceShip [

	self assertIsYourTurn: sourceShip in: aZathuraGame.
	aZathuraGame addCardToTable:
		(ActiveCard with: self appliedTo: { ship })
]

{ #category : #action }
SpeedCard >> assertIsYourTurn: aShip in: aZathuraGame [

	(aZathuraGame isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]
