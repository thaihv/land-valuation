package com.jdvn.valuation.landpublic.model;

import org.springframework.security.crypto.password.PasswordEncoder;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(schema = "landportal")
public class Member {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(unique = true)
	private String userid;

	private String pw;

	private String roles;

	private String email;

	private String firstName;

	private String lastName;

	private String phoneMobile;

	private String organisation;

	private String position;

	private Member(Long id, String userid, String pw, String email, String firstName, String lastName,
			String phoneMobile, String organisation, String position, String roleUser) {
		this.id = id;
		this.userid = userid;
		this.pw = pw;
		this.roles = roleUser;
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.phoneMobile = phoneMobile;
		this.organisation = organisation;
		this.position = position;
		;
	}

	protected Member() {
	}

	public static Member createUser(String userId, String pw, String email, String firstName, String lastName,
			String phoneAndMobail, String organisation, String position, PasswordEncoder passwordEncoder) {
		return new Member(null, userId, passwordEncoder.encode(pw), email, firstName, lastName, phoneAndMobail,
				organisation, position, "USER");
	}

	public Long getId() {
		return id;
	}

	public String getUserid() {
		return userid;
	}

	public String getPw() {
		return pw;
	}

	public String getRoles() {
		return roles;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getPhoneMobile() {
		return phoneMobile;
	}

	public String getOrganisation() {
		return organisation;
	}

	public String getEmail() {
		return email;
	}

	public String getPosition() {
		return position;
	}

}
