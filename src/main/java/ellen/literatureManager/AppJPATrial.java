package ellen.literatureManager;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import entities.Document;
import entities.Note;

public class AppJPATrial {
	private static EntityManagerFactory emf;
	
	public static void main(String [] args) {
		
		emf = Persistence.createEntityManagerFactory("pu1");
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
		Document doc = (Document)em.find(Document.class, 2);
		Note note = new Note(doc,"Muy buenos curries");
		
		et.begin();
		em.persist(note);
		et.commit();
		em.close();
	}
	
}
