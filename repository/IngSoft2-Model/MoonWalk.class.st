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
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'lockers'
	],
	#classInstVars : [
		'lockers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> with: aNumberOfLockers [

	^ self new intializeWith: aNumberOfLockers
]

{ #category : #'instance creation' }
MoonWalk >> action: aCollectionOfShips triggeredBy: aShip on: aBoard [

	| shipsToMove |
	shipsToMove := aCollectionOfShips select: [ :ship | ship ship ~= aShip ].
	shipsToMove do: [ :ship | aBoard move: ship ship by: (0 - lockers) ]
]

{ #category : #'class initialization' }
MoonWalk >> intializeWith: aNumberOfLockers [

	lockers := aNumberOfLockers
]
