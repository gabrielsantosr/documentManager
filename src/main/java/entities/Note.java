package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table (name="note")
public class Note extends IntIdEntity {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Integer id;
	
	@ManyToOne
	@JoinColumn(nullable=false)
	private Document document;
	
	@Column(name="note_text", nullable=false, length=3000)
	private String noteText;

	
	public Note() {
	}
	public Note(Document document, String text) {
		this.noteText = text;
		this.document = document;
	}
	@Override
	public Integer getId() {
		return id;
	}
	@Override
	public void setId(Integer id) {
		this.id = id;
	}
	public Document getDocument() {
		return document;
	}
	public void setDocument(Document document) {
		this.document = document;
	}
	public String getNoteText() {
		return noteText;
	}
	public void setNoteText(String noteText) {
		this.noteText = noteText;
	}

//	@Override
//	public List<Method> getLazyGetters() {
//		return lazyGetters;
//	}
}
//	@Transient
//	public static final List<Method>lazyGetters;
//	
//	static {
//			lazyGetters = initLazyGetters();
//	}
//	
//	
//	private static List<Method>initLazyGetters(){
//		List<Method>list = new ArrayList<>();
//		return list;
//	}
