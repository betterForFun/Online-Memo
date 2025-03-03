package com.example.Online.Memo.repository;

import java.util.List;

import com.example.Online.Memo.entity.Todo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface todoRepository extends JpaRepository<Todo, Integer>{
	public List<Todo> findByUsername(String username);
}
