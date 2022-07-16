Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accesing }
AccelerationCard >> changeOfRoll [
	^1
]

{ #category : #visiting }
AccelerationCard >> returnsEffectOfCardThrownBy: sourceShip on: aCardManager [

	^ PermanentCard new
		  returnsEffectOf: self thrownBy: sourceShip
		  on: aCardManager
]
