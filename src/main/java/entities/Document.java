package entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import dto.DocumentDTO;
import sub_entities.Volume;
@Entity
@Table(	name="document",
		uniqueConstraints= {
			@UniqueConstraint(columnNames = {"journal_name","vol_number","vol_release","year"}),
			@UniqueConstraint(columnNames = {"title","vol_number","vol_release","year"})})
public class Document extends IntIdEntity {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Integer id;
	
	@ManyToOne()
	@JoinColumn(name="doc_type_id")
	private DocumentType documentType;
	
	@OneToMany(mappedBy="document")
	@OrderBy("hierarchy")
	private List<Authorship> authorships;
	
	@Column
	private Integer year;
	
	@Column(name="journal_name", length=80)
	private String journalName;

	@Column(length=255)
	private String title;

	@Column(name="sub_title")
	private String subTitle;
	
	@Column
	private Volume volume;

	@Column
	private Integer edition;
	
	@Column
	private String publisher;
	
	@Column(name="publisher_location")
	private String publisherLocation;
	
	@Column(name="start_page")
	private Integer startPage;
	
	@Column(name="end_page")
	private Integer endPage;
	
	@Column
	private String doi;
	
	@Column
	private String source;
	
	@OneToMany(mappedBy="document")
	@OrderBy("id")
	protected List<Note>notes;
		 
	public Document() {
	}
	
	public Document(DocumentType documentType) {
		this.documentType = documentType;
	}
	
	public Document(DocumentDTO documentDTO) {
		setId(documentDTO.getId());
		setEdition(documentDTO.getEdition());
		setPublisher(documentDTO.getPublisher());
		setPublisherLocation(documentDTO.getPublisherLocation());
		DocumentType docType = new DocumentType();
		System.out.println(documentDTO.getDocType().get("id"));
		docType.setId((Integer)documentDTO.getDocType().get("id"));
		setDocumentType(docType);
		setYear(documentDTO.getYear());
		setTitle(documentDTO.getTitle());
		setSubTitle(documentDTO.getSubTitle());
		setJournalName(documentDTO.getJournalName());
		setVolume(documentDTO.getVolume());
		setStartPage(documentDTO.getStartPage());
		setEndPage(documentDTO.getEndPage());
		setDoi(documentDTO.getDoi());
		setSource(documentDTO.getSource());
	}

	@Override
	public Integer getId() {
		return id;
	}

	@Override
	public void setId(Integer id) {
		this.id = id;
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

	public DocumentType getDocumentType() {
		return documentType;
	}

	public void setDocumentType(DocumentType documentType) {
		this.documentType = documentType;
	}

	public List<Authorship> getAuthorships() {
		return authorships;
	}

	public void setAuthorships(List<Authorship> authorships) {
		this.authorships = authorships;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
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

	
	public List<Note> getNotes() {
		return notes;
	}

	public void setNotes(List<Note> notes) {
		this.notes = notes;
	}

//	@Override
//	public String toString() {
//		
//		Author authorshipAuthor = null;
//		String authorNames = "";
//		String []names = null;
//		if(authorships==null || authorships.size()==0) {
//			authorNames = "None";
//		} else {
//			for (Authorship authorship: authorships) {
//				authorNames+=(authorNames.length()!=0)?", ":"";
//				authorshipAuthor = authorship.getAuthor();
//				authorNames+= authorshipAuthor.getLastName()+",";
//				names=authorshipAuthor.getFirstName().split("\\s+");
//				for(String name:names) {
//					authorNames+=" "+name.substring(0,1)+".";
//				}
//			}
//		}
//		String qty=(notes==null)?"0":String.valueOf(notes.size());
//		return "Document [id: " + id + ", documentType: " + documentType.getDescription() + ", title: "
//				+ title + ", authors: "+authorNames +", notes: " + qty + "]";
//	}

//	@Override
//	public List<Method> getLazyGetters() {
//		return lazyGetters;
//	}	
}
// @Transient
//public static final List<Method>lazyGetters;
//
//static {
//		lazyGetters = initLazyGetters();
//}
//
//
//private static List<Method>initLazyGetters(){
//	List<Method>list = new ArrayList<>();
//	try {
//		list.add(Document.class.getMethod("getAuthorships"));
//		list.add(Document.class.getMethod("getNotes"));
//	} catch (NoSuchMethodException | SecurityException e) {
//		e.printStackTrace();
//	}
//	return list;
//}