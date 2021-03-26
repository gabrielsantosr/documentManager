package dto;

import entities.DocumentType;

public class DocumentTypeDTO {

	private Integer id;
	private String description;
	
	public DocumentTypeDTO(DocumentType docType) {
		id = docType.getId();
		description=docType.getDescription();
	}
	public DocumentTypeDTO() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
	

}
