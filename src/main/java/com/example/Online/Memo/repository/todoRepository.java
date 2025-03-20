package com.example.Online.Memo.repository;

import java.util.List;

import com.example.Online.Memo.entity.todo;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

public interface todoRepository extends JpaRepository<todo, Integer>{
	public List<todo> findByUsername(String username, Sort sort);
}
