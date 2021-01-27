package ellen.literatureManager;

import entities.Author;
import entities.Document;
import entities.DocumentType;
import service.DaoImpl;
import service.Service;

public class Test {
	
	public static void main(String []args) {
		Service service = new Service();
		Author author = (Author)service.get(Author.class, 3, false);
		System.out.println(author);
		
		service.getAll(DocumentType.class)
			.forEach(row->{System.out.println(row);});
	
		Document doc = (Document)service.get(Document.class, 4, true);
		//Note note = doc.getNotes().get(0);
		//linker.update(note, new Note(doc,"Esta nota volvió a ser alterada"));
		System.out.println(service.get(doc.getId(), author.getId()));
				
	}
}
