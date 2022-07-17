Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]

{ #category : #action }
SpeedCard >> returnsEffectOfCardThrownBy: sourceShip on: aCardManager [

	^ PermanentCard new
		  returnsEffectOf: self
		  thrownBy: sourceShip
		  on: aCardManager
]
