package ellen.literatureManager;

import java.util.List;


import entities.Author;
import entities.Document;
import entities.DocumentType;
import entities.IntIdEntity;
import entities.Note;
import service.Service;

public class Test {
	
	public static void main(String []args) {
		Service service = new Service();
		Author author = (Author)service.get(Author.class, 3, false);
		System.out.println(author);
		
		List <IntIdEntity>docTypes =service.getAll(DocumentType.class,true);
		for(IntIdEntity row: docTypes) {
			DocumentType docType = (DocumentType) row;
			System.out.println("\n"+docType.getDescription()+":");
			docType.getDocuments().forEach(doc->System.out.println("\t\u2022 "+doc.getTitle()));
		}
		
		List <IntIdEntity>notes =service.getAll(Note.class,false);
		for(IntIdEntity row: notes) {
			Note note = (Note) row;
			System.out.println(note);
		}
		
		Document doc = (Document)service.get(Document.class, 4, true);
		System.out.println(service.get(doc.getId(), author.getId()));
	}
}
