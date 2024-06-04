package com.jdvn.valuation.landpublic.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.jdvn.valuation.landpublic.model.Member;

@Component
public class MyUserDetailService implements UserDetailsService {

	private final MemberService memberService;

	public MyUserDetailService(MemberService memberService) {
		this.memberService = memberService;
	}

	@Override
	public UserDetails loadUserByUsername(String insertedUserId) throws UsernameNotFoundException {
		Optional<Member> findOne = memberService.findOne(insertedUserId);
		Member member = findOne.orElseThrow(() -> new UsernameNotFoundException("User has not been found!"));
		List<GrantedAuthority> roles = new ArrayList<>();
		roles.add(new SimpleGrantedAuthority(member.getRoles()));
		
		MyUserDetails memberContext = new MyUserDetails(member, roles);
		return memberContext;
	}
}
