package ellen.literatureManager;

import dao.DaoImpl;
import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;

public class TestDAO {
	public static void main(String []args) {
		DaoImpl linker = new DaoImpl();
		Author author = (Author)linker.get(Author.class, 3);
		System.out.println(author);
		
		linker.getAll(DocumentType.class)
			.forEach(row->{System.out.println(row);});
	
		Document doc = (Document)linker.getEager(Document.class,4);
		//Note note = doc.getNotes().get(0);
		//linker.update(note, new Note(doc,"Esta nota volvió a ser alterada"));
		System.out.println(linker.get(6,5));
				
	}
}
