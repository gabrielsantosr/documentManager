package dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import entities.Authorship;
import entities.Document;
import entities.DocumentType;

public class DocumentDTO {

	private Integer id;
	private Map<String,Object> docType;
	private List<AuthorDTO> authors;
	private String title;
	private String source;
	
	public DocumentDTO() {
		
	}
	
	public DocumentDTO(Document document) {
		this.id = document.getId();
		this.title = document.getTitle();
		this.source = document.getSource();
		docType = new HashMap<>();
		DocumentType dt = document.getDocumentType();
		docType.put("id", dt.getId());
		docType.put("type", dt.getDescription());
		authors = new ArrayList<>();
		AuthorDTO authorDTO;
		for (Authorship a : document.getAuthorships()) {
			authorDTO = new AuthorDTO(a.getAuthor());
			authorDTO.setDocuments(null);
			authors.add(authorDTO);
		}
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public Map<String, Object> getDocType() {
		return docType;
	}
	
	public void setDocType(Map<String, Object> docType) {
		this.docType = docType;
	}
	public List<AuthorDTO> getAuthors() {
		return authors;
	}
	public void setAuthors(List<AuthorDTO> authors) {
		this.authors = authors;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	
}
