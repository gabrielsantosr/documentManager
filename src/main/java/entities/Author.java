package entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;


@Entity
@Table(name="author")
public class Author extends IntIdEntity {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Integer id;
	//A comment
	@Column(name="last_name", length = 30)
	private String lastName;
	
	@Column(name="first_name", length = 30)
	private String firstName;
	
	@OneToMany(mappedBy="author")
	@OrderBy("hierarchy")
	private List<Authorship> authorships;
	
	public Author() {
	}

	public Author(String lastName, String firstName) {
		this.lastName = lastName;
		this.firstName = firstName;
	}

	@Override
	public Integer getId() {
		return id;
	}

	@Override
	public void setId(Integer id) {
		this.id = id;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public List<Authorship> getAuthorships() {
		return authorships;
	}

	public void setAuthorships(List<Authorship> authorships) {
		this.authorships = authorships;
	}

//	@Override
//	public List<Method> getLazyGetters() {
//		return lazyGetters;
//	}
}
//	@Transient
//	public static final List<Method>lazyGetters;
//	
//	static {
//			lazyGetters = initLazyGetters();
//	}
//	
//	private static List<Method>initLazyGetters(){
//		List<Method>list = new ArrayList<>();
//		try {
//			list.add(Author.class.getMethod("getAuthorships"));
//		} catch (NoSuchMethodException | SecurityException e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
