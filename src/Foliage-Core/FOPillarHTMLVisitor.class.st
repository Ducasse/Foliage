Class {
	#name : 'FOPillarHTMLVisitor',
	#superclass : 'FOPillarVisitor',
	#instVars : [
		'writer'
	],
	#category : 'Foliage-Core-Visitor',
	#package : 'Foliage-Core',
	#tag : 'Visitor'
}

{ #category : 'accessing' }
FOPillarHTMLVisitor >> contents [

	^ writer contents
]

{ #category : 'flushing' }
FOPillarHTMLVisitor >> flush [
	writer flush
]

{ #category : 'initialization' }
FOPillarHTMLVisitor >> initialize [ 
	super initialize.
	writer := HTMLWriter new
]

{ #category : 'visiting' }
FOPillarHTMLVisitor >> start: anObject [
	| result |
	result := self visit: anObject.
	writer flush.
	^ result
]

{ #category : 'accessing' }
FOPillarHTMLVisitor >> stream: aStream [ 
	writer stream: aStream
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitAnchor: anObject [

	^ self visitDocumentItem: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitAnnotatedParagraph: aDocument [
	self flag: #todo. "What happens with the annotations?"
	aDocument annotation isEmptyOrNil 
		ifFalse: [ self halt ].
	^ self visitParagraph: aDocument
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitBoldFormat: anObject [

	writer writeTag: 'strong' with: [ self visitFormat: anObject ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitCodeblock: aCodeBlock [

	writer newLine.
	writer writeTag: 'pre' with: [
		writer
			writeTag: 'code'
			with: [ self visitText: aCodeBlock replaceTabs ].
		"attributes: { (#class -> 'language-smalltalk') }" ].
	writer newLine.
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitCommentedLine: aCommentedLine [
	"ignore line"
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitDataItem: anObject [
	self halt.
	^ self visitListItem: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitDefinitionList: anObject [

	self halt.
	^ self visitList: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitEmptyParagraph: anObject [
	<ignoreForCoverage "This method is ignored for coverage because visiting an empty paragraph is typically very much different from visiting a paragraph.">
	
	self halt.
	^ self visitParagraph: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitExternalLink: anObject [

	writer
		  writeTag: 'a'
		  attributes: {
				  (#href -> anObject reference asString).
				  (#target -> '_blank') }
		  with: [ self visitLink: anObject ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitFigure: anObject [

	| ref uri |
	ref := anObject reference asZnUrl.
	uri := ref isRelative
		       ifTrue: [ '/' , ($/ join: ref segments) ]
		       ifFalse: [ ref asString ].
	writer
		  writeTag: 'img'
		  attributes:
		  { (#src -> uri) } , anObject parameters asDictionary associations
		  with: [  ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitFormat: anObject [
	^ self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitHeader: anObject [
	writer newLine.
	writer 
		writeHeaderLevel: anObject level 
		with: [ self visitDocumentGroup: anObject ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitHorizontalRule: anObject [

	writer writeTag: 'hr'
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitInternalLink: anObject [

	writer
		  writeTag: 'a'
		  attributes:
		  { (#href
		   -> ('javascript:alert(''{1}'')' format: { anObject anchor })) }
		  with: [ self visitText: (PRText content: anObject anchor) ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitItalicFormat: anObject [

	writer writeTag: 'i' with: [ self visitFormat: anObject ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitLineBreak: anObject [

	writer writeTag: 'br'
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitLink: anObject [

	^ self visitReference: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitList: anObject [

	writer newLine.
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitListItem: anObject [

	writer writeTag: 'li' with: [ self visitDocumentGroup: anObject ].	
	writer newLine
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitMonospaceFormat: anObject [

	writer writeTag: 'code' with: [ self visitFormat: anObject ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitOrderedList: anObject [

	writer newLine.
	writer writeTag: 'ol' with: [ self visitList: anObject ].
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitParagraph: anObject [

	writer newLine.
	writer 
		writeTag: 'p' 
		with: [ self visitDocumentGroup: anObject ]
]

{ #category : 'visiting-parameters' }
FOPillarHTMLVisitor >> visitParameter: anObject [
	self halt.
	^ self visitDocumentGroup: anObject 
]

{ #category : 'visiting-parameters' }
FOPillarHTMLVisitor >> visitParameterKey: anObject [
	self halt.
	^ self visitDocumentItem: anObject 
]

{ #category : 'visiting-parameters' }
FOPillarHTMLVisitor >> visitParameterValue: anObject [
	self halt.
	^ self visitDocumentItem: anObject 
]

{ #category : 'visiting-parameters' }
FOPillarHTMLVisitor >> visitParameters: anObject [
	^ self visitDocumentGroup: anObject 
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitPreformatted: anObject [

	writer writeTag: 'pre' with: [ self visitDocumentGroup: anObject ]
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitRaw: aRaw [

	^ self visitText: aRaw
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitReference: anObject [
	^ self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitSection: aSection [
	self halt.
	^ self visitDocumentGroup: aSection
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitStrikethroughFormat: anObject [
	self halt.
	^ self visitFormat: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitSubscriptFormat: anObject [
	self halt.
	^ self visitFormat: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitSuperscriptFormat: anObject [
	self halt.
	^ self visitFormat: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitTermItem: anObject [
	self halt.
	^ self visitListItem: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitText: anObject [
	writer writeText: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitUnderlineFormat: anObject [
	self halt.
	^ self visitFormat: anObject
]

{ #category : 'visiting-document' }
FOPillarHTMLVisitor >> visitUnorderedList: anObject [

	writer newLine.
	writer writeTag: 'ul' with: [ self visitList: anObject ].
]
