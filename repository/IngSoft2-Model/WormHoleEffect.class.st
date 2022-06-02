Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleEffect >> applyFor: aShip on: aBoard [

	aBoard move: aShip by: -4
]
