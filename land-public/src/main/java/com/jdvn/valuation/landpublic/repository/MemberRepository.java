package com.jdvn.valuation.landpublic.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jdvn.valuation.landpublic.model.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

	Optional<Member> findByUserid(String userId);
}
