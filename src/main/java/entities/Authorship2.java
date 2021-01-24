package entities;
/**
 *	NOT IN USE 
 */

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import sub_entities.AuthorDocumentLink;

/**
 *	NOT IN USE 
 */
@Entity
@Table(name="authorship")
public class Authorship2 {
	/**
	 *	NOT IN USE 
	 */
	@EmbeddedId
	private AuthorDocumentLink authorDocumentLink;
	private Integer hierarchy;
	
	
	public Authorship2(AuthorDocumentLink authorDocumentLink, Integer hierarchy) {
		this.authorDocumentLink = authorDocumentLink;
		this.hierarchy = hierarchy;
	}
	
	public Authorship2() {
		this.authorDocumentLink = new AuthorDocumentLink();
	}
	public Authorship2(Document doc,Author author, Integer hierarchy) {
		this.hierarchy = hierarchy;
		this.authorDocumentLink = new AuthorDocumentLink(author, doc);
	}
	public Authorship2(Document doc,Author author) {
		this.authorDocumentLink = new AuthorDocumentLink(author, doc);
	}
	
	public AuthorDocumentLink getAuthorDocumentLink() {
		return authorDocumentLink;
	}
	public void setAuthorDocumentLink(AuthorDocumentLink authorDocumentLink) {
		this.authorDocumentLink = authorDocumentLink;
	}
	public Integer getHierarchy() {
		return hierarchy;
	}
	public void setHierarchy(Integer hierarchy) {
		this.hierarchy = hierarchy;
	}
	
	


}