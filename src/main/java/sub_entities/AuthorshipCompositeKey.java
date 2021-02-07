package sub_entities;

import java.io.Serializable;

public class AuthorshipCompositeKey implements Serializable{

	/**
	 * 
			 */
	private static final long serialVersionUID = -3473634575133294542L;
	private Integer document;
	private Integer author;
	
//	public AuthorshipCompositeKey(Document document, Author author) {
//		this.document = document;
//		this.author = author;
//	}

	public AuthorshipCompositeKey() {
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((author == null) ? 0 : author.hashCode());
		result = prime * result + ((document == null) ? 0 : document.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AuthorshipCompositeKey other = (AuthorshipCompositeKey) obj;
		if (author == null) {
			if (other.author != null)
				return false;
		} else if (!author.equals(other.author))
			return false;
		if (document == null) {
			if (other.document != null)
				return false;
		} else if (!document.equals(other.document))
			return false;
		return true;
	}
	
}
