Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Card >> = aCard [
	^(self class = aCard class)
]

{ #category : #visiting }
Card >> returnsEffectOfCardThrownBy: sourceShip on: aCardManager [

	self subclassResponsibility
]
