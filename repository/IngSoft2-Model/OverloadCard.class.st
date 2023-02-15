Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
OverloadCard >> = aCard [

^(self class == aCard class).
]

{ #category : #action }
OverloadCard >> applyEffectTo: aShip on: aZathuraGame by: sourceShip [

	self assertIsYourTurn: sourceShip in: aZathuraGame.
	aZathuraGame addCardToTable:
		(ActiveCard with: self appliedTo: { aShip })
]

{ #category : #action }
OverloadCard >> assertIsYourTurn: aShip in: aZathuraGame [

	(aZathuraGame isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]
