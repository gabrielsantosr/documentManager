package controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import entities.Author;
import entities.IntIdEntity;
import entities.Note;
import service.EntityService;


@RestController
public class EntityController {

//	@Autowired
//	Service service;
	
	@RequestMapping(value="greet", produces = MediaType.APPLICATION_JSON_VALUE)
	public String greet() {
		return "3";
	}
	
	@Autowired
	EntityService service;

	@RequestMapping(value = "/authors", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public List<Author> autores() {
		List<IntIdEntity> fetched = service.getAll(Author.class, true);
		List<Author> authors = new ArrayList<>();
		for(IntIdEntity i: fetched) {
			authors.add((Author)i);
		}
		return authors;
	}
	
	@RequestMapping(value = "/notes", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public List<Note> notes() {
		List<IntIdEntity> fetched = service.getAll(Note.class, true);
		List<Note> notes = new ArrayList<>();
		for(IntIdEntity i: fetched) {
			notes.add((Note)i);
		}
		return notes;
	}
	
	@RequestMapping(value ="/author/{id}")
	public Author getAuthor(@PathVariable("id")int id) {
		return (Author) service.get(Author.class, id, false);
	}
	
	
}
