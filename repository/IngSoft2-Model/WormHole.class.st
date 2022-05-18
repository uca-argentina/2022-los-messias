Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> action: aShip on: aBoard [

	aBoard move: aShip by: -4
]
