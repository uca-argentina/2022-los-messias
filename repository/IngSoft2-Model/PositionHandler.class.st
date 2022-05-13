Class {
	#name : #PositionHandler,
	#superclass : #Object,
	#instVars : [
		'numberOfLockers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionHandler class >> with: aNumberOfLockers [
	^ self new initializeWith: aNumberOfLockers .
]

{ #category : #creating }
PositionHandler >> createNewPositionOf: positionOfShip by: aNumberOfLockers [

	| newPosition aLap aLocker |
	newPosition := positionOfShip numberOfLocker + aNumberOfLockers.
	aLap := positionOfShip numberOfLap + (newPosition // numberOfLockers).
	aLocker := newPosition % numberOfLockers.
	^ SpaceshipPosition for: positionOfShip ship at: aLap and: aLocker
]

{ #category : #initialization }
PositionHandler >> initializeWith: aNumberOfLockers [
	numberOfLockers := aNumberOfLockers 
]

{ #category : #creating }
PositionHandler >> moveToFinalPosition: aShipPosition [

	^ SpaceshipPosition for: aShipPosition ship at: aShipPosition numberOfLap and: 0
]
