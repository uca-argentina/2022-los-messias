"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two s
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	numberOfLockers:		<Object>


    Implementation Points
"
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
