Class {
	#name : #FOWebSite,
	#superclass : #Object,
	#instVars : [
		'targetPath',
		'templatePath',
		'rawModel',
		'rawPath',
		'model'
	],
	#category : #'Foliage-Core'
}

{ #category : #'as yet unclassified' }
FOWebSite >> allRawFiles [
	^ self rawPath allFiles 
]

{ #category : #building }
FOWebSite >> buildModel [
	| sources |
	sources := FORawModelCollector new 
		website: self;
		collect.
	^ FOSiteModelBuilder new
		website: self;
		build: sources;
		root.
]

{ #category : #accessing }
FOWebSite >> defaultRawPath [
	self subclassResponsibility 
]

{ #category : #accessing }
FOWebSite >> defaultTargetPath [
	self subclassResponsibility 
]

{ #category : #accessing }
FOWebSite >> defaultTemplatePath [ 
	self subclassResponsibility 
]

{ #category : #accessing }
FOWebSite >> rawModel [
	^ rawModel
]

{ #category : #accessing }
FOWebSite >> rawPath [
	^ rawPath ifNil: [ 
		rawPath := self defaultRawPath asFileReference ]
]

{ #category : #accessing }
FOWebSite >> rawPath: anObject [
	rawPath := anObject
]

{ #category : #'as yet unclassified' }
FOWebSite >> relativeRawPath: aFileReference [
	^ aFileReference relativeTo: rawPath asAbsolute
]

{ #category : #accessing }
FOWebSite >> targetPath [
	^ targetPath ifNil: [ 
		targetPath := self defaultTargetPath asFileReference ]
]

{ #category : #accessing }
FOWebSite >> targetPath: anObject [
	targetPath := anObject
]

{ #category : #accessing }
FOWebSite >> templatePath [
	^ templatePath ifNil: [ 
		templatePath := self defaultTemplatePath asFileReference ]
]

{ #category : #accessing }
FOWebSite >> templatePath: anObject [
	templatePath := anObject
]