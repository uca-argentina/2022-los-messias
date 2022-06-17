Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> = card [

	^(self hasEqualClass: card)
]

{ #category : #action }
AccelerationCard >> applyEffectToAllShipsIn: aZathuraGame by: sourceShip [

	self assertIsYourTurn: sourceShip  in: aZathuraGame. 
	aZathuraGame addCardToTable:
		(ActiveCard with: self appliedTo: aZathuraGame ships)
]

{ #category : #asserting }
AccelerationCard >> assertIsYourTurn: aShip in: zathuraGame [

	(zathuraGame isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #accesing }
AccelerationCard >> changeOfRoll [
	^1
]
