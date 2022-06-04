Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBombEffect >> applyFor: aShip on: aBoard [
aBoard moveAllToLockerZero
]
