package dao;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import entities.IntIdEntity;
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
		
		session = sf.openSession();
		return session;
	}
	private Session getSessionWithTransaction() {
 		transaction = getSession().beginTransaction();
		return session;
	}
	private Transaction getCurrentTransaction() {
		return transaction;
	}
	
	private void closeSession() {
			session.close();
	}
	private void closeSessionWithTransaction() {
			transaction.commit();
			session.close();
	}

	@Override
	public IntIdEntity get(Class<? extends IntIdEntity> entityClass,Integer id) {
		getSession();
		IntIdEntity fetched = (IntIdEntity) session.get(entityClass, id);
		this.closeSession();
		return fetched;
	}
	
	

	@Override
	public boolean save(IntIdEntity rowType) {
		boolean success = false;
		getSessionWithTransaction();
		try {
			session.save(rowType);
			success = true;
		} catch (Exception e) {
			getCurrentTransaction().rollback();
		}
		closeSessionWithTransaction();
		return success;

	}

	@Override
	public boolean update(IntIdEntity oldData, IntIdEntity newData) {
		if(!oldData.getClass().equals(newData.getClass())) {
			return false;
		}
		boolean success = false;
		
		getSessionWithTransaction();
		try {
			newData.setId(oldData.getId());
			session.update(newData);
			success = true;
		} catch (Exception e) {
			getCurrentTransaction().rollback();
		}
		
		closeSessionWithTransaction();
		return success;
	}

	@Override
	public boolean delete(IntIdEntity rowType) {
		boolean success = false;
		getSessionWithTransaction();
		try {
			session.delete(rowType);
			success = true;
		} catch (Exception e) {
			getCurrentTransaction().rollback();
		}
		this.closeSessionWithTransaction();
		return success;
	}

	@Override
	public List<IntIdEntity> getAll(Class<? extends IntIdEntity> clazz) {
		getSession();
		
		List<IntIdEntity> lista = null;
		Query q = session.createQuery("FROM "+ clazz.getName());
		lista = (List<IntIdEntity>) (q.list());
		closeSession();
		return lista;
	}

	@Override
	public IntIdEntity getEager(Class<? extends IntIdEntity> entityClass, Integer id) {
		getSession();
		IntIdEntity fetched = (IntIdEntity) session.get(entityClass, id);
		for (Method getter: fetched.getLazyGetters()) {
			try {
				Hibernate.initialize(getter.invoke(fetched,null));
			} catch (HibernateException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		this.closeSession();
		return fetched;
	}

	@Override
	public List<IntIdEntity> getAllEager(Class<? extends IntIdEntity> entityClass) {
		getSession();
		
		return null;
	}
}
