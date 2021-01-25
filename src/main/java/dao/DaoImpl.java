package dao;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

import entities.AbstractEntity;
import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import entities.Note;

public class DaoImpl implements DAO{
	

	private SessionFactory sf;
	private Session session;
	private Transaction transaction;
	
	public DaoImpl(){
		Configuration config = new Configuration().configure()
    			.addAnnotatedClass(Document.class)
    			.addAnnotatedClass(DocumentType.class)
    			.addAnnotatedClass(Author.class)
    			.addAnnotatedClass(Authorship.class)
    			.addAnnotatedClass(Note.class);
    	ServiceRegistry reg = new ServiceRegistryBuilder().applySettings(config.getProperties()).buildServiceRegistry();
    	sf = config.buildSessionFactory(reg);
	}

	private Session getSession() {
//		session = sf.getCurrentSession();
//		if(session==null) {
//			session = sf.openSession();
//		}
		
		return sf.openSession();
	}
	private Session getSessionWithTransaction() {
 		transaction = getSession().beginTransaction();
		return session;
	}
	public Transaction getCurrentTransaction() {
		return transaction;
	}
	
	private void closeSession() {
		if(session != null) {
			session.close();
		}
	}
	private void commitTransaction() {
		if (transaction!=null && !transaction.wasRolledBack()) {
			transaction.commit();
		}
	}

	@Override
	public AbstractEntity get(Class<? extends AbstractEntity> entityClass,Integer id) {
		Session s = getSession();
		AbstractEntity fetched = (AbstractEntity) s.get(entityClass, id);
		this.closeSession();
		return fetched;
	}
	

	@Override
	public boolean save(AbstractEntity rowType) {
		boolean success = false;
		Session s = this.getSessionWithTransaction();
		try {
			s.save(rowType);
			success = true;
		} catch (Exception e) {
			this.getCurrentTransaction().rollback();
		}
		this.commitTransaction();
		this.closeSession();
		return success;

	}

	@Override
	public boolean update(AbstractEntity oldData, AbstractEntity newData) {
		boolean success = false;
		Session s = this.getSessionWithTransaction();
		try {
			newData.setId(oldData.getId());
			s.update(newData);
			success = true;
		} catch (Exception e) {
			this.getCurrentTransaction().rollback();
		}
		
		this.commitTransaction();
		this.closeSession();

		return success;
	}

	@Override
	public boolean delete(AbstractEntity rowType) {
		boolean success = false;
		Session s = this.getSessionWithTransaction();
		try {
			s.delete(rowType);
			success = true;
		} catch (Exception e) {
			this.getCurrentTransaction().rollback();
		}
		this.commitTransaction();
		this.closeSession();
		return success;
	}

	@Override
	public List<AbstractEntity> getAll(Class<? extends AbstractEntity> clazz) {
		Session s = this.getSession();
		try {
			String qText = "FROM "+ clazz.getName();
			Query q = s.createQuery(qText);
			
			System.out.println(qText);
			return (List<AbstractEntity>)(q.list());
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
}
