Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
AccelerationCard >> = aCard [

^(self class == aCard class).
]

{ #category : #action }
AccelerationCard >> applyEffectToAllShipsOn: aZathuraGame by: sourceShip [

	self assertIsYourTurn: sourceShip in: aZathuraGame .

	aZathuraGame  addCardToTable:
		(ActiveCard with: self appliedTo: aZathuraGame  ships)
]

{ #category : #asserting }
AccelerationCard >> assertIsYourTurn: aShip in: aZathuraGame [

	(aZathuraGame isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #accessing }
AccelerationCard >> changeOfRoll [
	^1
]
