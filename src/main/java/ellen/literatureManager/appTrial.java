package ellen.literatureManager;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import entities.Note;

public class appTrial {
	public static void main(String [] args) {
		
		Configuration config = new Configuration().configure()
				.addAnnotatedClass(Document.class)
				.addAnnotatedClass(DocumentType.class)
				.addAnnotatedClass(Author.class)
				.addAnnotatedClass(Authorship.class)
				.addAnnotatedClass(Note.class);
		SessionFactory sf = config.buildSessionFactory();
		Session session = sf.openSession();
		Document doc = (Document)session.load(Document.class, 6);
		System.out.println(doc);
		session.close();
	}
	
}
