package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import dto.AuthorDTO;
import dto.DocumentDTO;
import dto.DocumentTypeDTO;
import dto.FileDTO;
import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;

@Component
public class DtoService {
	
	private DtoDAO dtoDAO;
	
	public DtoService() {
		this.dtoDAO = new DtoDAO();
	}
	
	public AuthorDTO getAuthorDTO(Integer id) {
		dtoDAO.enableSession();
		Author author = dtoDAO.getAuthor(id);
		AuthorDTO aDTO = new AuthorDTO(author);
		dtoDAO.closeSession();
		return aDTO;
	}
	
	
	public List<AuthorDTO>getAllAuthorDTO(){
		dtoDAO.enableSession();
		List<Author>fetched = dtoDAO.getAllAuthor();
		List<AuthorDTO>authorDTOList = new ArrayList<>();
		for (Author author: fetched) {
			authorDTOList.add(new AuthorDTO(author));
		}
		dtoDAO.closeSession();
		return authorDTOList;
	}
	
	public DocumentDTO getDocumentDTO(Integer id) {
		dtoDAO.enableSession();
		Document doc = dtoDAO.getDocument(id);
		DocumentDTO dDTO = new DocumentDTO(doc);
		dtoDAO.closeSession();
		return dDTO;
	}
	
	public List<DocumentDTO>getAllDocumentDTO(){
		dtoDAO.enableSession();
		List<Document>fetched = dtoDAO.getAllDocument();
		List<DocumentDTO> list = new ArrayList<>();
		for(Document doc : fetched) {
			list.add(new DocumentDTO(doc));
		}
		dtoDAO.closeSession();
		return list;
	}
	
	public FileDTO getFileDTO(Integer id) {
		dtoDAO.enableSession();
		Document doc = dtoDAO.getDocument(id);
		FileDTO fDTO = new FileDTO(doc.getSource());
		dtoDAO.closeSession();
		return fDTO;
	}
	
	public List<DocumentTypeDTO>getAllDocumentTypeDTO(){
		dtoDAO.enableSession();
		List<DocumentType>docTypes = dtoDAO.getAllDocumentType();
		List<DocumentTypeDTO> docTypeDTOs = new ArrayList<>();
		for (DocumentType docType: docTypes) {
			docTypeDTOs.add(new DocumentTypeDTO(docType));
		}
		dtoDAO.closeSession();
		return docTypeDTOs;
	}
	
	public void saveAuthorFromDTO(AuthorDTO authorDTO) {
		Author author = new Author(authorDTO.getLastName(),authorDTO.getFirstName());
		dtoDAO.enableSession();
		dtoDAO.enableTransaction();
		authorDTO.setId(dtoDAO.saveAuthor(author));
		dtoDAO.commitTransaction();
		dtoDAO.closeSession();
	}
	
	public void saveDocumentFromDTO(DocumentDTO docDTO) {
		Document doc = new Document(docDTO);
		dtoDAO.enableSession();
		dtoDAO.enableTransaction();
		docDTO.setId(dtoDAO.saveDocument(doc));
		int hierarchy = 0;
		List<AuthorDTO>authorDTOs = docDTO.getAuthors();
		for (AuthorDTO authorDTO: authorDTOs) {
			Author author = null;
			if (authorDTO.getId()== null) {
				author = new Author(authorDTO.getLastName(),authorDTO.getFirstName());
				authorDTO.setId(dtoDAO.saveAuthor(author));
			} else {
				author = dtoDAO.getAuthor(authorDTO.getId());
			}
			hierarchy++;
			Authorship authorship = new Authorship(doc,author);
			authorship.setHierarchy(hierarchy);
			dtoDAO.saveAuthorship(authorship);
		}
		dtoDAO.commitTransaction();
		dtoDAO.closeSession();
	}

}
