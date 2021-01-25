package ellen.literatureManager;

import dao.DaoImpl;
import entities.Author;
import entities.DocumentType;

public class TestDAO {
	public static void main(String []args) {
		DaoImpl linker = new DaoImpl();
		Author author = (Author)linker.get(Author.class, 1);
		System.out.println(author);
		
		linker.getAll(DocumentType.class)
			.forEach(row->{System.out.println(row);});
		
	}

}
