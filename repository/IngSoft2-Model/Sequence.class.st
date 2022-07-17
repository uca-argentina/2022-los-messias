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

{ #category : #'instance creation' }
Sequence class >> with: aCollection [

	^ self new initializeWith: aCollection asOrderedCollection 
]

{ #category : #enumerating }
Sequence >> asArray [

	^ collection asArray
]

{ #category : #enumerating }
Sequence >> detect: aBlock [

	^ collection detect: aBlock
]

{ #category : #'accessing - attributes' }
Sequence >> first [
	^ collection first 
]

{ #category : #enumerating }
Sequence >> includes: aBlock [

	^ collection includes: aBlock
]

{ #category : #initialization }
Sequence >> initializeWith: aCollection [ 
	
	collection := aCollection 
]

{ #category : #'change set' }
Sequence >> next [

	| aValue |
	aValue := collection removeFirst.
	collection addLast: aValue.
	^ aValue
]

{ #category : #enumerating }
Sequence >> select: aBlock [

	^ collection select: aBlock
]
