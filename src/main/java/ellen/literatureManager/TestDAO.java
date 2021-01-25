package ellen.literatureManager;

import dao.Linker;
import entities.Author;

public class TestDAO {
	public static void main(String []args) {
		Linker linker = new Linker();
		Author author = (Author)linker.get(Author.class, 1);
		System.out.println(author);
	}

}
