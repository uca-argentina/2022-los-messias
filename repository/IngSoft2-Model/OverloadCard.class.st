Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> addIn: zathuraGame appliedTo: ship [

	zathuraGame addCardToTable:
		(ActiveCard with: self appliedTo: { ship })
]

{ #category : #action }
OverloadCard >> applyEffectTo: ship in: zathuraGame by: sourceShip [

	zathuraGame throw: self.
	self assertIsYourTurn: sourceShip in: zathuraGame.
	self addIn: zathuraGame appliedTo: ship
]

{ #category : #action }
OverloadCard >> assertIsYourTurn: aShip in: zathuraGame [

	(zathuraGame isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ] 
]

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]
