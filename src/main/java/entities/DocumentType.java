package entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="doc_type")
public class DocumentType extends AbstractEntity {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column
	private Integer id;
	
	@Column(length=16)
	private String description;
	
	@OneToMany(mappedBy="documentType")
	private List<Document> documents;
	
	

	public DocumentType() {
		// TODO Auto-generated constructor stub
	}

	public DocumentType(String description) {
		this.description = description;
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

	public List<Document> getDocuments() {
		return documents;
	}

	public void setDocuments(List<Document> documents) {
		this.documents = documents;
	}

	@Override
	public String toString() {
		return "DocumentType [id=" + id + ", description=" + description + "]";
	}
	
	
}
