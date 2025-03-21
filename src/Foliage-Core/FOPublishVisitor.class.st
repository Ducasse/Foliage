Class {
	#name : 'FOPublishVisitor',
	#superclass : 'FOModelVisitor',
	#category : 'Foliage-Core-Visitor',
	#package : 'Foliage-Core',
	#tag : 'Visitor'
}

{ #category : 'visiting' }
FOPublishVisitor >> copyResource: aResource [ 
	| target |
	target := aResource publishPath asFileReference.
	target exists ifTrue: [  target delete ].
	aResource sourcePath asFileReference copyTo: target
]

{ #category : 'visiting' }
FOPublishVisitor >> visitBlog: aFOBlog [ 

	^ super visitWebFolder: aFOBlog
]

{ #category : 'visiting' }
FOPublishVisitor >> visitBlogPost: aFOBlogPost [ 
	^ self visitMicrodownPage: aFOBlogPost 
]

{ #category : 'visiting' }
FOPublishVisitor >> visitFileObject: aFileObject [ 
	aFileObject emit.
	self copyResource: aFileObject.
	^ aFileObject 
]

{ #category : 'visiting' }
FOPublishVisitor >> visitHTMLPageSource: aFOHTMLPageSource [ 
	aFOHTMLPageSource emit.
	self copyResource: aFOHTMLPageSource.
	^ aFOHTMLPageSource 
]

{ #category : 'visiting' }
FOPublishVisitor >> visitMicrodownPage: aMicrodownPage [

	aMicrodownPage emit.
	aMicrodownPage publish.
	^ aMicrodownPage 
]

{ #category : 'visiting' }
FOPublishVisitor >> visitPillarPage: aFOPillarPage [ 
	aFOPillarPage emit.
	aFOPillarPage publish.
	^ aFOPillarPage 
]

{ #category : 'visiting' }
FOPublishVisitor >> visitRSSFeed: aFORSSFeed [ 
	| template targetPath stream |
	
	aFORSSFeed emit.
	template := (aFORSSFeed website templatePath / #'rss.xml') asMustacheTemplate.
	targetPath := aFORSSFeed publishPath asFileReference.
	stream := targetPath writeStream
		truncate;
		nextPutAll: (template value: aFORSSFeed);
		flush; 
		close.
	^ aFORSSFeed 
]

{ #category : 'visiting' }
FOPublishVisitor >> visitWebFolder: aFOWebsiteFolder [
	aFOWebsiteFolder emit.
	aFOWebsiteFolder createOnTarget.
	^ super visitWebFolder: aFOWebsiteFolder 
]

{ #category : 'visiting' }
FOPublishVisitor >> visitWebImage: aWebImage [ 
	aWebImage emit.
	self copyResource: aWebImage.
	^ aWebImage 
]
