Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyEffectTo: ship in: zathuraGame by: sourceShip [

	self assertIsYourTurn: sourceShip in: zathuraGame.
	zathuraGame addCardToTable:
		(ActiveCard with: self appliedTo: { ship }).
	zathuraGame throw: self.
]

{ #category : #action }
SpeedCard >> assertIsYourTurn: aShip in: zathuraGame [

	(zathuraGame isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]
