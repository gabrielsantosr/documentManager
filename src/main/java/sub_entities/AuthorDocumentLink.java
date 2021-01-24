package sub_entities;

/**
 *	NOT IN USE 
 */

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
/**
 *	NOT IN USE 
 */

import entities.Author;
import entities.Document;
/**
 *	NOT IN USE 
 */

@Embeddable
public class AuthorDocumentLink implements Serializable {
	/**
	 *	NOT IN USE 
	 */
	private static final long serialVersionUID = 4552743516815521353L;

	@JoinColumn(name="author")
	@ManyToOne()
	private Author author;
	
	@JoinColumn(name="document")
	@ManyToOne()
	private Document document;
	
	public AuthorDocumentLink() {
		
	}

	public AuthorDocumentLink(Author author, Document document) {
		super();
		this.author = author;
		this.document = document;
	}

	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
	}

	public Document getDocument() {
		return document;
	}

	public void setDocument(Document document) {
		this.document = document;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((author == null) ? 0 : author.hashCode());
		result = prime * result + ((document == null) ? 0 : document.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AuthorDocumentLink other = (AuthorDocumentLink) obj;
		if (author == null) {
			if (other.author != null)
				return false;
		} else if (!author.equals(other.author))
			return false;
		if (document == null) {
			if (other.document != null)
				return false;
		} else if (!document.equals(other.document))
			return false;
		return true;
	}
	

}
