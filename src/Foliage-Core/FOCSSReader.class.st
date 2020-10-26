Class {
	#name : #FOCSSReader,
	#superclass : #FORawReader,
	#category : #'Foliage-Core'
}

{ #category : #testing }
FOCSSReader class >> supportedFileExtensions [ 
	^ #( css ) 
]

{ #category : #accessing }
FOCSSReader >> model [ 
	^ FOCSSObject new 
		raw: file
]