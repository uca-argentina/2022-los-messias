Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]

{ #category : #visiting }
OverloadCard >> returnsEffectOfCardThrownBy: sourceShip on: aCardManager [

	^ PermanentCard new
		  returnsEffectOf: self
		  thrownBy: sourceShip
		  on: aCardManager
]
