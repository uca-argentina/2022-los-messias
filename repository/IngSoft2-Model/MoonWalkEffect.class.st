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
	lockers:		<Object>


    Implementation Points
"
Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'lockers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
MoonWalkEffect class >> assertIsValid: aNumberOfLockers [

	aNumberOfLockers > 0 ifFalse: [ Error signal: 'MoonWalk cannot be created with less than zero lockers' ]
]

{ #category : #'instance creation' }
MoonWalkEffect class >> with: aNumberOfLockers [

	self assertIsValid: aNumberOfLockers.
	^ self new intializeWith: aNumberOfLockers
]

{ #category : #action }
MoonWalkEffect >> applyFor: aShip on: aBoard [

aBoard moveAllShipsBackwardsExcept: aShip by: lockers
]

{ #category : #'class initialization' }
MoonWalkEffect >> intializeWith: aNumberOfLockers [

	lockers := aNumberOfLockers
]
