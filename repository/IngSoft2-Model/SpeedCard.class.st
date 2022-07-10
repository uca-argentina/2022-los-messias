Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
SpeedCard >> accept: aCardManager [

	^ [ :aCard :aShip :sourceShip | 
	  aCardManager applyEffectOf: aCard to: aShip thrownBy: sourceShip ]
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
