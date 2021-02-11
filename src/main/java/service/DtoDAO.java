package service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import dto.AuthorDTO;
import dto.DocumentDTO;
import entities.Author;
import entities.Document;

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

	protected AuthorDTO getAuthorDTO(Integer id) {
		Author author = (Author) session.get(Author.class, id);
		return new AuthorDTO(author);
	}

	protected List<AuthorDTO> getAllAuthorDTO() {
		Query q = session.createQuery("FROM " + Author.class.getName());
		@SuppressWarnings("unchecked")
		List<Author> authors = q.list();
		List<AuthorDTO> authorDTOs = new ArrayList<>();
		for (Author author : authors) {
			authorDTOs.add(new AuthorDTO(author));
		}
		return authorDTOs;
	}

	protected Integer saveAuthorFromDTO(AuthorDTO authorDTO) {
		 Author newAuthor =  new Author(authorDTO.getLastName(),authorDTO.getFirstName());
		 Integer authorID=null;
		 try {
		 authorID = (Integer) session.save(newAuthor);
		 }catch(Exception e) {
			 transaction.rollback();
		 }
		 return authorID;
	}
	
	protected List<DocumentDTO>getAllDocumentDTO(){
		Query q = session.createQuery("FROM " + Document.class.getName());
		@SuppressWarnings("unchecked")
		List<Document> docs = q.list();
		List<DocumentDTO> docDTOs = new ArrayList<>();
		for (Document doc : docs) {
			docDTOs.add(new DocumentDTO(doc));
		}
		return docDTOs;
	}

}
