"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
!
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	numberOfLap:		<Object>
	numberOfLocker:		<Object>
	ship:		<Object>


    Implementation Points
"
Class {
	#name : #ShipPosition,
	#superclass : #Object,
	#instVars : [
		'ship',
		'numberOfLap',
		'numberOfLocker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ShipPosition class >> for: aShip at: lap and: locker [
	^self new initializeFor: aShip at: lap and: locker.
]

{ #category : #'logical operations' }
ShipPosition >> > aSpaceshipPosition [

	| condition |
	condition := self compareTo: aSpaceshipPosition.
	^ condition
]

{ #category : #'logical operations' }
ShipPosition >> compareTo: aSpaceshipPosition [

	| condition |
	condition := numberOfLap > aSpaceshipPosition numberOfLap.
	numberOfLap == aSpaceshipPosition numberOfLap ifTrue: [ 
		condition := numberOfLocker > aSpaceshipPosition numberOfLocker ].
	^ condition
]

{ #category : #initialization }
ShipPosition >> initializeFor: aShip at: aLap and: aLockerNumber [
	ship := aShip.
	numberOfLap := aLap.
	numberOfLocker := aLockerNumber .
]

{ #category : #accessing }
ShipPosition >> numberOfLap [

	^ numberOfLap 
]

{ #category : #accessing }
ShipPosition >> numberOfLocker [
	^ numberOfLocker
]

{ #category : #accessing }
ShipPosition >> ship [
	^ship
]
