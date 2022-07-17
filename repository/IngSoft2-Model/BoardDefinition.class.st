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
	laps:		<Object>
	lockers:		<Object>
	parsecs:		<Object>


    Implementation Points
"
Class {
	#name : #BoardDefinition,
	#superclass : #Object,
	#instVars : [
		'lockers',
		'laps',
		'unit'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
BoardDefinition class >> assertLapsAreValid: laps [

	laps > 0 ifFalse: [ 
		Error signal: 'Board Structure cannot have less than zero laps' ]
]

{ #category : #asserting }
BoardDefinition class >> assertLockersAreValid: aNumberOfLockers [

	aNumberOfLockers > 1 ifFalse: [ 
		Error signal: 'Board Structure cannot have less than two lockers' ]
]

{ #category : #asserting }
BoardDefinition class >> assertParsecsAreValid: parsecs [

	parsecs > 0 ifFalse: [ 
		Error signal: 'Board Structure cannot have less than zero parsecs' ]
]

{ #category : #'instance creation' }
BoardDefinition class >> with: lockers and: unit played: laps [

	self assertLockersAreValid: lockers size.
	self assertParsecsAreValid: unit valueAsParsec.
	self assertLapsAreValid: laps.
	^ self new initializeWith: lockers and: unit played: laps
]

{ #category : #initialization }
BoardDefinition >> initializeWith: aCollectionOfLockers and: aUnit played: aNumberLaps [

	lockers := aCollectionOfLockers.
	unit := aUnit.
	laps := aNumberLaps
]

{ #category : #accesing }
BoardDefinition >> laps [
	^ laps
]

{ #category : #accesing }
BoardDefinition >> lockerAt: num [

	^ lockers at: num
]

{ #category : #accesing }
BoardDefinition >> numberOfLockers [

^ lockers size
]

{ #category : #accesing }
BoardDefinition >> unitPerLocker [

	^ (lockers size / unit valueAsParsec ) asFloat
]
