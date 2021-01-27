package ellen.literatureManager;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import service.DaoImpl;

public class TestDAO {
	private DaoImpl chePibe;
	public TestDAO() {
		this.chePibe = new DaoImpl();
	}
	
	public static void main(String []args) {
		TestDAO test = new TestDAO();
		Author author = (Author)test.chePibe.get(Author.class, 3);
		System.out.println(author);
		
		test.chePibe.getAll(DocumentType.class)
			.forEach(row->{System.out.println(row);});
	
		Document doc = (Document)test.chePibe.getEager(Document.class,4);
		//Note note = doc.getNotes().get(0);
		//linker.update(note, new Note(doc,"Esta nota volvió a ser alterada"));
		System.out.println(test.chePibe.get(6,5));
				
	}
}
