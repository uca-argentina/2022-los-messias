Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'ship',
		'numberOfLaps',
		'numberOfLockers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition class >> for: aShip at: lap and: locker [
	^self new initializeFor: aShip at: lap and: locker.
]

{ #category : #'logical operations' }
SpaceshipPosition >> > aSpaceshipPosition [ 
	^(numberOfLockers > aSpaceshipPosition numberOfLockers).
]

{ #category : #initialization }
SpaceshipPosition >> initializeFor: aShip at: aLap and: aLockerNumber [
	ship := aShip.
	numberOfLaps := aLap.
	numberOfLockers := aLockerNumber .
]

{ #category : #accessing }
SpaceshipPosition >> numberOfLockers [
	^ numberOfLockers
]

{ #category : #accessing }
SpaceshipPosition >> spaceship [
	^ship
]
