Class {
	#name : #JailEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
JailEffect >> applyFor: aShip on: aBoard [ 
	
	aBoard addToJail: aShip
]
