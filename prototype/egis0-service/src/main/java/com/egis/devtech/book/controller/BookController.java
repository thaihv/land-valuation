package com.egis.devtech.book.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.oidc.StandardClaimNames;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.egis.devtech.book.domain.Book;
import com.egis.devtech.book.repository.BookRepository;

@RestController
@CrossOrigin(origins = "*")
public class BookController {

	@Autowired
	private BookRepository bookRepository;
	
	@SuppressWarnings({ "rawtypes", "unchecked", "serial" })
	@GetMapping
	@RequestMapping(value = "/secured/testHi", method = RequestMethod.GET)
	@PreAuthorize("hasAuthority('Admin')")
	public HashMap welcome() {
		var credentials = (Jwt) SecurityContextHolder.getContext().getAuthentication().getCredentials();
		return new HashMap() {
			{
				put("From", "egis0-service");
				put("UserID", credentials.getSubject());
				put("Hello",  credentials.getClaim(StandardClaimNames.NAME));
				put("Email",  credentials.getClaim(StandardClaimNames.EMAIL));
				put("Preferred Username", credentials.getClaim(StandardClaimNames.PREFERRED_USERNAME));
			}
		};
	}

	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<Book> getAllBooks() {
		return bookRepository.findAll();
	}

	@GetMapping("/find/{id}")
	public Optional<Book> findBookById(@PathVariable Long id) {
		return bookRepository.findById(id);
	}

	@PutMapping("/update/{id}")
	@PreAuthorize("hasAuthority('Admin')")
	public Book updateBook(@RequestBody Book book) {
		return bookRepository.saveAndFlush(book);
	}

	@PostMapping("/create")
	@PreAuthorize("hasAuthority('Admin')")
	public List<Book> createBook(@RequestBody Book book) {
		bookRepository.saveAndFlush(book);
		return bookRepository.findAll();
	}

	@DeleteMapping("/delete/{id}")
	@PreAuthorize("hasAuthority('Admin')")
	public void deleteBook(@PathVariable Long id) {
		bookRepository.deleteById(id);
	}
}