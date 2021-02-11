package dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import entities.Author;
import entities.Authorship;
import entities.Document;

public class AuthorDTO {
	
	private Integer id;
	private String firstName;
	private String lastName;
	private Map<Integer,String>documents;

	public AuthorDTO() {
		
	}
	public AuthorDTO(Author author) {
		id = author.getId();
		firstName = author.getFirstName();
		lastName = author.getLastName();
		this.setDocumentsFromAuthor(author.getAuthorships());
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public Map<Integer,String> getDocuments() {
		return documents;
	}
	public void setDocuments(Map<Integer,String> docs) {
		this.documents = docs;
	}
	public void setDocumentsFromAuthor(List<Authorship>authorships) {
		documents = new HashMap<>();
		Document d;
		for(Authorship i:authorships) {
			d = i.getDocument();
			documents.put(d.getId(),d.getTitle());
		}
	}
}
