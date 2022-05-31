Class {
	#name : #AtomicBombEffect,
	#superclass : #Locker,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBombEffect >> applyFor: aShip on: aBoard [
aBoard moveAllToLockerZero
]
