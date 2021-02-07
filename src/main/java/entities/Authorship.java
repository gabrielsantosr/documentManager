package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import sub_entities.AuthorshipCompositeKey;

@Entity
@Table(name="authorship")
@IdClass(AuthorshipCompositeKey.class)
public class Authorship {
	@Id
//	@JoinColumn(name="author_id")
	@ManyToOne()
	private Author author;

	@Id
//	@JoinColumn(name="document_id")
	@ManyToOne()
	private Document document;

	@Column(name="hierarchy")
	private Integer hierarchy;
	

	
	public Authorship() {
	}

	public Authorship(Document document, Author author) {
		this.document = document;
		this.author = author;
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

	public Integer getHierarchy() {
		return hierarchy;
	}

	public void setHierarchy(Integer hierarchy) {
		this.hierarchy = hierarchy;
	}

	@Override
	public String toString() {
		return "Authorship [author=" + author + ", document=" + document + ", hierarchy=" + hierarchy + "]";
	}
	

}
