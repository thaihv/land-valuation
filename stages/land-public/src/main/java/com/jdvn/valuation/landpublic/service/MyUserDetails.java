package com.jdvn.valuation.landpublic.service;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.jdvn.valuation.landpublic.model.Member;

import lombok.Getter;

@Getter
public class MyUserDetails extends User {
	private static final long serialVersionUID = 1L;
	private final Member member;

    public MyUserDetails(Member member, Collection<? extends GrantedAuthority> authorities) {
        super(member.getUserid(), member.getPw(), authorities);
        this.member = member;
    }
}