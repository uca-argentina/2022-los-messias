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

{ #category : #'class initialization' }
MoonWalk >> action: aShip on: aBoard [

	| ships |
	ships := self getAllShipsIn: aBoard except: aShip.
	self moveAll: ships In: aBoard
]

{ #category : #'class initialization' }
MoonWalk >> getAllShipsIn: aBoard except: aShip [

	| ships |
	ships := aBoard AllNameOfShips select: [ :ship | ship ~= aShip ].
	^ ships
]

{ #category : #'class initialization' }
MoonWalk >> intializeWith: aNumberOfLockers [

	lockers := aNumberOfLockers
]

{ #category : #private }
MoonWalk >> moveAll: ships In: aBoard [

	ships do: [ :ship | 
		aBoard move: ship by: lockers * -1 ]
]
