package com.example.Online.Memo.todo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface todoRepository extends JpaRepository<Todo, Integer>{
	public List<Todo> findByusername(String username);
}
