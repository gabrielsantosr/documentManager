package dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import sub_entities.Volume;

public class DocumentDTO {

	private Integer id;
	private Map<String,Object> docType;
	private List<AuthorDTO> authors;
	private Integer year;
	private String title;
	private String subTitle;
	private String journalName;
	private Volume volume;
	private Integer edition;
	private String publisher;
	private String publisherLocation;
	private Integer startPage;
	private Integer endPage;
	private String doi;
	private String source;
	private Integer approxRequiredLengthForFile;


	public DocumentDTO() {

	}

	public DocumentDTO(Document document) {
		this.id = document.getId();
		this.year = document.getYear();
		this.title = document.getTitle();
		this.subTitle = document.getSubTitle();
		this.journalName = document.getJournalName();
		this.volume = document.getVolume();
		this.edition = document.getEdition();
		this.publisher = document.getPublisher();
		this.publisherLocation = document.getPublisherLocation();
		this.startPage = document.getStartPage();
		this.endPage = document.getEndPage();
		this.doi = document.getDoi();
		docType = new HashMap<>();
		DocumentType dt = document.getDocumentType();
		docType.put("id", dt.getId());
		docType.put("description", dt.getDescription());
		authors = new ArrayList<>();
		AuthorDTO authorDTO;
		for (Authorship a : document.getAuthorships()) {
			authorDTO = new AuthorDTO(a.getAuthor());
			authorDTO.setDocuments(null);/*AuthorDTO has associated DocumentDTOs and viceversa. This line is to avoid an infinite DTO*/
			authors.add(authorDTO);
		}
		try {
			
			FileDTO fileDTO = new FileDTO(document.getSource());
			approxRequiredLengthForFile = fileDTO.getData().length * 4 / 3;
		}catch(Exception e) {
			approxRequiredLengthForFile = 0;
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

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public Integer getApproxRequiredLengthForFile() {
		return approxRequiredLengthForFile;
	}

	public void setApproxRequiredLengthForFile(Integer fileLength) {
		this.approxRequiredLengthForFile = fileLength;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public String getJournalName() {
		return journalName;
	}

	public void setJournalName(String journalName) {
		this.journalName = journalName;
	}

	public Volume getVolume() {
		return volume;
	}

	public void setVolume(Volume volume) {
		this.volume = volume;
	}

	public Integer getEdition() {
		return edition;
	}

	public void setEdition(Integer edition) {
		this.edition = edition;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPublisherLocation() {
		return publisherLocation;
	}

	public void setPublisherLocation(String publisherLocation) {
		this.publisherLocation = publisherLocation;
	}

	public Integer getStartPage() {
		return startPage;
	}

	public void setStartPage(Integer startPage) {
		this.startPage = startPage;
	}

	public Integer getEndPage() {
		return endPage;
	}

	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	}

	public String getDoi() {
		return doi;
	}

	public void setDoi(String doi) {
		this.doi = doi;
	}
	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String toString() {
		String auths="";
		for (AuthorDTO a: authors) {
			auths +="\n{id: "+a.getId()+", firstName: "+a.getFirstName()+", lastName: "+a.getLastName()+"}";
		}
		return "id: "+id+
				"\nTitle: "+title+
				"\nYear: "+year+
				"\nAuthors: ["+auths+"]"+
				"\ndocType: "+ docType.get("type");
	}
}
