package entities;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="doc_type")
public class DocumentType extends EntityParent {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column
	private Integer id;
	
	@Column(length=16)
	private String description;
	
	@OneToMany(mappedBy="documentType")
	private List<Document> documents;
	
	@Transient
	private List<Method>lazyGetters;
	
	

	public DocumentType() {
		lazyGetters = new ArrayList<>();
		try {
			lazyGetters.add(this.getClass().getMethod("getDocuments"));
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public DocumentType(String description) {
		lazyGetters = new ArrayList<>();
		try {
			lazyGetters.add(this.getClass().getMethod("getDocuments"));
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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

	@Override
	public List<Method> getLazyGetters() {
		return lazyGetters;
	}

		
	
}
