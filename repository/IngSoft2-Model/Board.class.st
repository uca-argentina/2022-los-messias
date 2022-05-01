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
	numberOfLockers:		<Object>
	positionOfShips:		<Object>


    Implementation Points
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfLockers',
		'positionOfShips'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValid: numberOfLockers [

	numberOfLockers >= 2 ifFalse: [ 
		Error signal: 'Zathura cannot be played with a board with less than two lockers' ]
]

{ #category : #initialization }
Board class >> of: aNumberOfLockers withAll: aCollectionOfShips [
	self assertValid: aNumberOfLockers.
	^self new initializeWith: aNumberOfLockers andWithAGroupOf: aCollectionOfShips  .
]

{ #category : #getvsrev43 }
Board >> didShipCrossFinishLine: aShip [

	^ (positionOfShips at: aShip) >= numberOfLockers 
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfLockers andWithAGroupOf: ships [

	numberOfLockers := aNumberOfLockers.
	positionOfShips := Dictionary new.
	ships do:
		self initializingPositionOfShipsWithAllShipsAtPositionZero
]

{ #category : #initialization }
Board >> initializingPositionOfShipsWithAllShipsAtPositionZero [

	^ [ :aShip | positionOfShips at: aShip put: 0 ]
]

{ #category : #moving }
Board >> move: aShip by: aNumberOfLockers [

	| actualPosition |
	actualPosition := self positionOfShip: aShip.
	positionOfShips at: aShip put: actualPosition + aNumberOfLockers.
	[ self didShipCrossFinishLine: aShip ] ifTrue: [ 
		positionOfShips at: aShip put: numberOfLockers ]
]

{ #category : #getvsrev43 }
Board >> positionOfShip: aShip [

	^ positionOfShips at: aShip 
]
