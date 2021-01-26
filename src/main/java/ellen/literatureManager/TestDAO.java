package ellen.literatureManager;

import dao.DaoImpl;
import entities.Author;
import entities.Document;
import entities.DocumentType;
import entities.Note;

public class TestDAO {
	public static void main(String []args) {
		DaoImpl linker = new DaoImpl();
		Author author = (Author)linker.get(Author.class, 1);
		System.out.println(author);
		
		linker.getAll(DocumentType.class)
			.forEach(row->{System.out.println(row);});
	
		Document doc = (Document)linker.getEager(Document.class,2);
		Note note = doc.getNotes().get(0);
		linker.update(note, new Note(doc,"Nota alterada"));
		
	}

}
