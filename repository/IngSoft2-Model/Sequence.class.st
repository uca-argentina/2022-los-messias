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
	collection:		<Object>


    Implementation Points
"
Class {
	#name : #Sequence,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Sequence class >> assertValid: aCollection [

	aCollection size <= 0 ifTrue: [ 
		Error signal:
			'Sequence should not be loaded with an empty Collection' ]
]

{ #category : #'instance creation' }
Sequence class >> with: aCollection [

	| newOrderedCollection |
	self assertValid: aCollection.
	^ self new initializeWith: aCollection asOrderedCollection 
]

{ #category : #accessing }
Sequence >> collection [

	^collection 
]

{ #category : #initialization }
Sequence >> initializeWith: aCollection [ 
	collection := aCollection 
]

{ #category : #'change set' }
Sequence >> next [
	| aValue |
	aValue := collection removeFirst.
	collection addLast: aValue
]

{ #category : #accessing }
Sequence >> value [

	^ collection at: 1
]
