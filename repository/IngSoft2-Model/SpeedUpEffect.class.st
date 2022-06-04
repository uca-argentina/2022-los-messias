Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUpEffect >> applyFor: aShip on: aBoard [

	aBoard move: aShip by: 4.
]
