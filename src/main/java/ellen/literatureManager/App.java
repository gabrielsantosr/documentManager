package ellen.literatureManager;

import java.util.ArrayList;
import java.util.List;

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
import entities.Note;


public class App {
    public static void main( String[] args ) {
    	
    	List<Object>toPersist= new ArrayList<Object>();
    	String mainPath="C:\\Users\\gabri\\OneDrive\\Escritorio\\";
    	
    	Author oliverSacks, katieCaldessi, giancarloCaldessi, joshuaMarinacci, 
    			chrisAdamson, jackSantaMaria, johnLennon, paulMcCartney,
    			georgeHarrison, ringoStarr= null;
    	
    	DocumentType book = new DocumentType("Book");
    	toPersist.add(book);
    	DocumentType audio = new DocumentType("Audio");
    	toPersist.add(audio);
    	
    	Document pasta, indian, swing, musicophilia, manWifeHat, revolver = null;
    	
    	Note note1, note2, note3, note4, note5, note6= null;

    	ringoStarr = new Author("Starr","Ringo");
    	toPersist.add(ringoStarr);
    	jackSantaMaria = new Author("Santa Maria","Jack");
    	toPersist.add(jackSantaMaria);
    	oliverSacks = new Author("Sacks","Oliver");
    	toPersist.add(oliverSacks);
    	katieCaldessi = new Author("Caldessi","Katie");
    	toPersist.add(katieCaldessi);
    	johnLennon = new Author("Lennon","John");
    	toPersist.add(johnLennon);
    	giancarloCaldessi = new Author("Caldessi","Giancarlo");
    	toPersist.add(giancarloCaldessi);
    	joshuaMarinacci = new Author("Marinacci","Joshua");
    	toPersist.add(joshuaMarinacci);
    	georgeHarrison = new Author("Harrison","George");
    	toPersist.add(georgeHarrison);
    	chrisAdamson = new Author("Adamson","Chris");
    	toPersist.add(chrisAdamson);
    	paulMcCartney = new Author("McCartney","Paul");
    	toPersist.add(paulMcCartney);
    	
    	pasta = new Document(book);
    	toPersist.add(pasta);
    	pasta.setTitle("The long and the short of Pasta");
    	pasta.setSubTitle("A collection of treasured Italian dishes");
    	pasta.setSource(mainPath+"pasta.jpg");
    	indian = new Document(book);
    	toPersist.add(indian);
    	indian.setTitle("Indian vegetarian coockery");
    	indian.setSource(mainPath+"indian.jpg");
    	swing = new Document(book);
    	toPersist.add(swing);
    	swing.setTitle("Swing Hacks");
    	swing.setSource(mainPath+"swing_hacks.png");
    	musicophilia = new Document(book);
    	toPersist.add(musicophilia);
    	musicophilia.setTitle("Musicophilia");
    	musicophilia.setSource(mainPath+"musicophilia.jpg");
    	manWifeHat = new Document(book);
    	toPersist.add(manWifeHat);
    	manWifeHat.setTitle("The Man Who Mistook his Wife For A Hat");
    	manWifeHat.setSource(mainPath+"hat.jpg");
    	revolver = new Document(audio);
    	toPersist.add(revolver);
    	revolver.setTitle("Revolver");
    	revolver.setSource("https://open.spotify.com/album/3PRoXYsngSwjEQWR5PsHWR?si=QZoGinDLREKGrsRoCtDqGQ");
    	
    	Authorship sacksHat = new Authorship(manWifeHat,oliverSacks);
    	toPersist.add(sacksHat);
    	sacksHat.setHierarchy(1);

    	Authorship sacksMus = new Authorship(musicophilia,oliverSacks);
    	toPersist.add(sacksMus);
    	sacksMus.setHierarchy(1);
    	
    	Authorship pastaKc = new Authorship(pasta,katieCaldessi);
    	toPersist.add(pastaKc);
    	pastaKc.setHierarchy(1);
    	
    	Authorship pastaGc = new Authorship(pasta,giancarloCaldessi);
    	toPersist.add(pastaGc);
    	pastaGc.setHierarchy(2);
    	
    	Authorship indianJsm = new Authorship(indian,jackSantaMaria);
    	toPersist.add(indianJsm);
    	indianJsm.setHierarchy(1);
    	
    	Authorship caSwing = new Authorship(swing,chrisAdamson);
    	toPersist.add(sacksHat);
    	caSwing.setHierarchy(2);

    	Authorship jmSwing = new Authorship(swing,joshuaMarinacci);
    	toPersist.add(jmSwing);
    	jmSwing.setHierarchy(1);
    	
    	
    	Authorship revGh = new Authorship(revolver,georgeHarrison);
    	toPersist.add(revGh);
    	revGh.setHierarchy(3);
    	
    	Authorship revPmc = new Authorship(revolver,paulMcCartney);
    	toPersist.add(revPmc);
    	revPmc.setHierarchy(2);
    	
    	Authorship revJl = new Authorship(revolver,johnLennon);
    	toPersist.add(revJl);
    	revJl.setHierarchy(1);
    	
    	Authorship revRs = new Authorship(revolver,ringoStarr);
    	toPersist.add(revRs);
    	revRs.setHierarchy(4);
    	
    	note1 = new Note(revolver,"Qué bueno que está!!");
    	toPersist.add(note1);
    	note2 = new Note(manWifeHat,"Acerca del descubrimiento del funcionamiento cerebral a partir de sus fallas");
    	toPersist.add(note2);
    	note3 = new Note(pasta,"Tiene buenas instrucciones para hacer la pasta casera");
    	toPersist.add(note3);
    	note4 = new Note(manWifeHat,"Tiene historias de casos estudiados por el mismo autor");
    	toPersist.add(note4);
    	note5 = new Note(swing,"Éste me dio idea para construir un analizador de ondas sonoras");
    	toPersist.add(note5);
    	note6 = new Note(revolver,"Eleanor Rigby, For No One, y otros éxitos");
    	toPersist.add(note6);
    	
    	Configuration config = new Configuration().configure()
    			.addAnnotatedClass(Document.class)
    			.addAnnotatedClass(DocumentType.class)
    			.addAnnotatedClass(Author.class)
    			.addAnnotatedClass(Authorship.class)
    			.addAnnotatedClass(Note.class);
    	ServiceRegistry reg = new ServiceRegistryBuilder().applySettings(config.getProperties()).buildServiceRegistry();
    	SessionFactory sf = config.buildSessionFactory(reg);
    	Session session = sf.openSession();
    	Transaction transaction = session.beginTransaction();
    	
    	Object fail= new Object();
    	try {
    		for ( Object o: toPersist) {
    			fail = o;
    			session.persist(o);
    		}
    	}catch (Exception e) {
			transaction.rollback();
			System.out.println(fail);
		}
    	
    	transaction.commit();
    	session.close();
    }
}
