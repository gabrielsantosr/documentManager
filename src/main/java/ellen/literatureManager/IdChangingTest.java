package ellen.literatureManager;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.Author;
import service.SingleSessionFactory;
/*
 * This application doesn't work. It's purpose is to make sure that
 * changes in persistent objects' IDs are not permitted. Had it been
 * otherwise, IDs should be declared as final.
 */
public class IdChangingTest {
	public static void main(String[] args) {
		SessionFactory factory = SingleSessionFactory.getInstance();
		Session session = factory.openSession();
		Transaction transaction = session.beginTransaction();
		Author author = (Author)session.load(Author.class, 2);
		author.setId(19);
		transaction.commit();
		session.close();
	}

}
