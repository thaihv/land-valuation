package com.jdvn.valuation.landpublic.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.jdvn.valuation.landpublic.model.Member;
import com.jdvn.valuation.landpublic.repository.MemberRepository;

@Service
public class MemberService {
	
    private final MemberRepository repository;

    public MemberService(MemberRepository repository) {
        this.repository = repository;
    }

    public Optional<Member> findOne(String userId) {
        return repository.findByUserid(userId);
    }
}
