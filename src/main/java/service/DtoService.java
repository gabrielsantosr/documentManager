package service;

import java.util.List;

import org.springframework.stereotype.Component;

import dto.AuthorDTO;

@Component
public class DtoService {
	
	private DtoDAO dtoDAO;
	
	public DtoService() {
		this.dtoDAO = new DtoDAO();
	}
	
	public AuthorDTO getAuthorDTO(Integer id) {
		dtoDAO.enableSession();
		AuthorDTO fetched = dtoDAO.getAuthorDTO(id);
		dtoDAO.closeSession();
		return fetched;
	}
	
	public List<AuthorDTO>getAllAuthorDTO(){
		dtoDAO.enableSession();
		List<AuthorDTO>fetched = dtoDAO.getAllAuthorDTO();
		dtoDAO.closeSession();
		return fetched;
	}
	
	public void saveAuthorFromDTO(AuthorDTO authorDTO){
		dtoDAO.enableSession();
		dtoDAO.enableTransaction();
		Integer assignedAuthorID = dtoDAO.saveAuthorFromDTO(authorDTO);
		if(assignedAuthorID != null) {
			dtoDAO.commitTransaction();
		} 
		dtoDAO.closeSession();
		authorDTO.setId(assignedAuthorID);
	}

}
