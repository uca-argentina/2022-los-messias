Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'ship',
		'numberOfLap',
		'numberOfLocker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition class >> for: aShip at: lap and: locker [
	^self new initializeFor: aShip at: lap and: locker.
]

{ #category : #'logical operations' }
SpaceshipPosition >> > aSpaceshipPosition [

	| condition |
	condition := self compareTo: aSpaceshipPosition.
	^ condition
]

{ #category : #'logical operations' }
SpaceshipPosition >> compareTo: aSpaceshipPosition [

	| condition |
	condition := numberOfLap > aSpaceshipPosition numberOfLap.
	numberOfLap == aSpaceshipPosition numberOfLap ifTrue: [ 
		condition := numberOfLocker > aSpaceshipPosition numberOfLocker ].
	^ condition
]

{ #category : #initialization }
SpaceshipPosition >> initializeFor: aShip at: aLap and: aLockerNumber [
	ship := aShip.
	numberOfLap := aLap.
	numberOfLocker := aLockerNumber .
]

{ #category : #accessing }
SpaceshipPosition >> numberOfLap [

	^ numberOfLap 
]

{ #category : #accessing }
SpaceshipPosition >> numberOfLocker [
	^ numberOfLocker
]

{ #category : #accessing }
SpaceshipPosition >> ship [
	^ship
]
