package service;

import java.util.List;

import org.springframework.stereotype.Component;

import dto.AuthorDTO;
import dto.DocumentDTO;
import dto.FileDTO;

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
	
	public DocumentDTO getDocumentDTO(Integer id) {
		dtoDAO.enableSession();
		DocumentDTO fetched = dtoDAO.getDocumentDTO(id);
		dtoDAO.closeSession();
		return fetched;
	}
	
	public List<DocumentDTO>getAllDocumentDTO(){
		dtoDAO.enableSession();
		List<DocumentDTO>fetched = dtoDAO.getAllDocumentDTO();
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
	
	public FileDTO getFileDTO(Integer id) {
		dtoDAO.enableSession();
		FileDTO fileDTO = dtoDAO.getFileDTO(id);
		dtoDAO.closeSession();
		return fileDTO;
	}

}
