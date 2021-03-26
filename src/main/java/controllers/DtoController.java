package controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import dto.AuthorDTO;
import dto.DocumentDTO;
import dto.DocumentTypeDTO;
import dto.FileDTO;
import service.DtoService;

@RestController
public class DtoController {

	@Autowired
	DtoService dtoService;
	@RequestMapping(value = "trial")
	public String getTrial() {
		return "TRIAL";
	}

	@RequestMapping(value = "author_dto/{id}")
	public AuthorDTO getAuthorDTO(@PathVariable("id") int id) {
		return dtoService.getAuthorDTO(id);
	}

	@RequestMapping(value = "author_dto")
	public List<AuthorDTO> getAllAuthorDTO() {
		return dtoService.getAllAuthorDTO();
	}

	@RequestMapping(value = "new_author_dto", method = RequestMethod.POST)
	public AuthorDTO newAuthor(@RequestBody AuthorDTO authorDTO) {
			dtoService.saveAuthorFromDTO(authorDTO);
			return authorDTO;
	}
	
	@RequestMapping(value = "document_dto")
	public List<DocumentDTO> getAllDocumentDTO() {
		return dtoService.getAllDocumentDTO();
	}
	
	@RequestMapping(value = "file/{id}")
	public FileDTO getFile(@PathVariable("id") int id) {
		return dtoService.getFileDTO(id);
	}
	
	@RequestMapping(value="doc_types")
	public List<DocumentTypeDTO> getAllDocumentTypeDTO(){
		return dtoService.getAllDocumentTypeDTO();
	}
}
