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
		'positionOfShips',
		'numberOfLaps'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValid: numberOfLockers [

	numberOfLockers >= 2 ifFalse: [ 
		Error signal: 'Board cannot be created with less than two lockers' ]
]

{ #category : #'instance creation' }
Board class >> of: lockers and: laps withAll: aCollectionOfShips [

	self assertValid: lockers.
	^ self new
		  initializeWith: lockers
		  and: laps
		  withAGroupOf: aCollectionOfShips
]

{ #category : #initialization }
Board >> hasCrossFinishLine: aShip [

	^ (positionOfShips at: aShip) >= numberOfLockers 
]

{ #category : #initialization }
Board >> initializeWith: lockers and: laps withAGroupOf: aCollectionOfShips [

	numberOfLockers := lockers.
	numberOfLaps := laps.
	positionOfShips := Dictionary new.
	aCollectionOfShips do: [ :aShip | positionOfShips at: aShip put: 0 ]
]

{ #category : #moving }
Board >> move: aShip by: aNumberOfLockers [

	| actualPosition |
	actualPosition := positionOfShips at: aShip.
	positionOfShips
		at: aShip
		put:
		(actualPosition + aNumberOfLockers min:
			 numberOfLockers * numberOfLaps)
]

{ #category : #'accessing - attributes' }
Board >> numberOfLapsOf: aShip [

	^ (positionOfShips at: aShip) // numberOfLockers
]

{ #category : #'accessing - attributes' }
Board >> numberOfLockersOf: aShip [

	^ (positionOfShips at: aShip) % numberOfLockers
]

{ #category : #'accessing - attributes' }
Board >> rankingOf: aString [ 
	self shouldBeImplemented.
]
