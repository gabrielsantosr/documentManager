package service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import sub_entities.AuthorshipCompositeKey;

public class DtoDAO {

	private SessionFactory sf;
	private Session session;
	private Transaction transaction;

	protected DtoDAO() {
		sf = SingleSessionFactory.getInstance();
	}

	protected void enableSession() {
		if (session == null || !session.isOpen()) {
			session = sf.openSession();
		}
	}

	protected void enableTransaction() {
		if (transaction == null || transaction.wasCommitted()) {
			transaction = session.beginTransaction();
		}
	}
	protected Transaction getTransaction() {
		return transaction;
	}
	protected void commitTransaction() {
		if (!transaction.wasCommitted()) {
			transaction.commit();
		}
	}

	protected void closeSession() {
		if (session != null && session.isOpen()) {
			session.close();
		}
	}

	protected Author getAuthor(Integer id) {
		return (Author)session.get(Author.class, id);
	}

		
	@SuppressWarnings("unchecked")
	protected List<Author>getAllAuthor(){
		Query q = session.createQuery("FROM "+Author.class.getName());
		return q.list();
	}
	
	@SuppressWarnings("unchecked")
	protected List<Document> getAllDocument(){
		Query q = session.createQuery("FROM " + Document.class.getName());
		return q.list();
	}
	
	@SuppressWarnings("unchecked")
	protected List<DocumentType>getAllDocumentType(){
		Query q = session.createQuery("FROM "+DocumentType.class.getName());
		return q.list();
	}
	
	protected Document getDocument(Integer id) {
		return (Document) session.get(Document.class, id);
	}
	
	protected Integer saveDocument(Document document) {
		return (Integer) session.save(document);
	}
	protected Integer saveAuthor(Author author) {
		return (Integer) session.save(author);
	}
	
	protected AuthorshipCompositeKey saveAuthorship(Authorship authorship) {
		return (AuthorshipCompositeKey) session.save(authorship);
	}

}
