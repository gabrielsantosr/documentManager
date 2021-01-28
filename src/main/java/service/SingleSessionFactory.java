package service;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import entities.Note;

public class SingleSessionFactory {
	
	private static SessionFactory sf;
	
	public SingleSessionFactory() {
		
	}
	public static synchronized SessionFactory getInstance() {
		if (sf == null) {
			Configuration config = new Configuration().configure()
	    			.addAnnotatedClass(Document.class)
	    			.addAnnotatedClass(DocumentType.class)
	    			.addAnnotatedClass(Author.class)
	    			.addAnnotatedClass(Authorship.class)
	    			.addAnnotatedClass(Note.class);
	    	ServiceRegistry reg = new ServiceRegistryBuilder().applySettings(config.getProperties()).buildServiceRegistry();
	    	sf = config.buildSessionFactory(reg);
		}
		return sf;
	}

}
