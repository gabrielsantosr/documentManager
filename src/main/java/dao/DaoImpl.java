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
import entities.EntityParent;
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
	public Transaction getCurrentTransaction() {
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
	public EntityParent get(Class<? extends EntityParent> entityClass,Integer id) {
		getSession();
		EntityParent fetched = (EntityParent) session.get(entityClass, id);
		this.closeSession();
		return fetched;
	}
	

	@Override
	public boolean save(EntityParent rowType) {
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
	public boolean update(EntityParent oldData, EntityParent newData) {
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
	public boolean delete(EntityParent rowType) {
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
	public List<EntityParent> getAll(Class<? extends EntityParent> clazz) {
		getSession();
		List<EntityParent> lista = null;
		try {
			String qText = "FROM "+ clazz.getName();
			Query q = session.createQuery(qText);
			
			System.out.println(qText);
			lista = (List<EntityParent>)(q.list());
		} catch (Exception e) {
		}
		closeSession();
		return lista;
	}

	@Override
	public EntityParent getEager(Class<? extends EntityParent> entityClass, Integer id) {
		getSession();
		EntityParent fetched = (EntityParent) session.get(entityClass, id);
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
	public List<EntityParent> getAllEager(Class<? extends EntityParent> entityClass) {
		// TODO Auto-generated method stub
		return null;
	}
}
