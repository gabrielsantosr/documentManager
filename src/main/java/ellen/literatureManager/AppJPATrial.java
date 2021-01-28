package ellen.literatureManager;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import entities.Document;

public class AppJPATrial {
	private static EntityManagerFactory emf;
	
	public static void main(String [] args) {
		
		emf = Persistence.createEntityManagerFactory("pu1");
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
		et.begin();
		Document doc = (Document)em.find(Document.class, 2);
		doc.setId(19);
		et.commit();
		em.close();
	}
	
}
