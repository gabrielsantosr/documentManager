package service;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import entities.IntIdEntity;
import entities.Note;

public class EntityDaoImpl implements EntityDAO{
	

	private SessionFactory sf;
	private Session session;
	private Transaction transaction;
	private Map<Class<? extends IntIdEntity>,List<Method>> lazyGetters;
	private Map<Class<? extends IntIdEntity>,List<Method>> lazySetters;
	
	public EntityDaoImpl(){
		sf = SingleSessionFactory.getInstance();
		lazyGetters = new HashMap<>();
		lazySetters = new HashMap<>();
		List<Method> authorLazyGetters = new ArrayList<>();
		List<Method> documentLazyGetters = new ArrayList<>();
		List<Method> docTypeLazyGetters = new ArrayList<>();
		List<Method> noteLazyGetters = new ArrayList<>();
		List<Method> authorLazySetters = new ArrayList<>();
		List<Method> documentLazySetters = new ArrayList<>();
		List<Method> docTypeLazySetters = new ArrayList<>();
		List<Method> noteLazySetters = new ArrayList<>();
		try {
			authorLazyGetters.add(Author.class.getMethod("getAuthorships"));
			documentLazyGetters.add(Document.class.getMethod("getAuthorships"));
			documentLazyGetters.add(Document.class.getMethod("getNotes"));
			docTypeLazyGetters.add(DocumentType.class.getMethod("getDocuments"));
			
			authorLazySetters.add(Author.class.getMethod("setAuthorships",List.class));
			documentLazySetters.add(Document.class.getMethod("setAuthorships",List.class));
			documentLazySetters.add(Document.class.getMethod("setNotes", List.class));
			docTypeLazySetters.add(DocumentType.class.getMethod("setDocuments",List.class));
			
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
		}
		lazyGetters.put(Author.class,authorLazyGetters);
		lazyGetters.put(Document.class,documentLazyGetters);
		lazyGetters.put(DocumentType.class,docTypeLazyGetters);
		lazyGetters.put(Note.class,noteLazyGetters);

		lazySetters.put(Author.class,authorLazySetters);
		lazySetters.put(Document.class,documentLazySetters);
		lazySetters.put(DocumentType.class,docTypeLazySetters);
		lazySetters.put(Note.class,noteLazySetters);
	}

	
	protected void enableSession() {
		if (session==null || !session.isOpen()) {
			session = sf.openSession();
		}
	}
	
	protected void enableTransaction() {
		if (transaction==null || transaction.wasCommitted()) {
			transaction = session.beginTransaction();
		}
	}
	
	protected void commitTransaction() {
		if (!transaction.wasCommitted()) {
			transaction.commit();
		}
	}
	
	protected void closeSession() {
		if (session!=null && session.isOpen()) {
			session.close();
		}
	}
	
	@Override
	public IntIdEntity get(Class<? extends IntIdEntity> entityClass,Integer id) {
		IntIdEntity fetched = (IntIdEntity) session.get(entityClass, id);
		session.evict(fetched);
		
		for (Method m: lazySetters.get(entityClass)) {
			try {
				m.invoke(fetched, new ArrayList<>());
			} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return fetched;
	}
	
	
	@Override
	public Authorship get(Integer docId, Integer authorId) {
		SQLQuery sqlQuery =session
				.createSQLQuery("SELECT * FROM authorship where document_id=:dID AND author_id =:aID");
		sqlQuery.addEntity(Authorship.class);
		sqlQuery.setParameter("dID", docId);
		sqlQuery.setParameter("aID", authorId);
		Authorship fetched = (Authorship) sqlQuery.uniqueResult();
		Hibernate.initialize(fetched.getDocument().getAuthorships());
		Hibernate.initialize(fetched.getDocument().getNotes());
		return fetched;
	}

	@Override
	public boolean save(Object row) {
		boolean success = false;
		try {
			session.save(row);
			success = true;
		} catch (Exception e) {
			transaction.rollback();
		}
		return success;
	}

	@Override
	public boolean update(IntIdEntity oldData, IntIdEntity newData) {
		if(!oldData.getClass().equals(newData.getClass())) {
			return false;
		}
		boolean success = false;
		
		try {
			newData.setId(oldData.getId());
			
			session.update(newData);
			success = true;
		} catch (Exception e) {
			transaction.rollback();
		}
		return success;
	}

	@Override
	public boolean delete(IntIdEntity rowType) {
		boolean success = false;
		try {
			session.delete(rowType);
			success = true;
		} catch (Exception e) {
			transaction.rollback();
		}
		return success;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IntIdEntity> getAll(Class<? extends IntIdEntity> entityClass) {
		
		List<IntIdEntity> lista = null;
		Query q = session.createQuery("FROM "+ entityClass.getName());
		lista = q.list();
		return lista;
	}

	@Override
	public IntIdEntity getEager(Class<? extends IntIdEntity> entityClass, Integer id) {
		IntIdEntity fetched = (IntIdEntity) session.get(entityClass, id);
		for (Method getter: lazyGetters.get(fetched.getClass())) {
			try {
				Hibernate.initialize(getter.invoke(fetched));
			} catch (HibernateException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return fetched;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IntIdEntity> getAllEager(Class<? extends IntIdEntity> entityClass) {
		List<IntIdEntity> lista = null;
		Query q = session.createQuery("FROM "+ entityClass.getName());
		lista = (q.list());
			for (Method getter: lazyGetters.get(entityClass)) {
				for (IntIdEntity row: lista) {
					try {
						Hibernate.initialize(getter.invoke(row));
					} catch (HibernateException | IllegalAccessException | IllegalArgumentException
							| InvocationTargetException e) {
						e.printStackTrace();
					}
				}
			}
		return lista;
	}
}
