package com.example.Online.Memo.entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Size;



@Entity
public class todo {

	@Id
	@GeneratedValue
	private int id;
	private String username;
	@Size(min = 1, message = "Description cannot be Empty")
	private String description;
	private LocalDate date;
	private boolean done;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public LocalDate getDate() {
		return date;
	}
	public void setDate(LocalDate date) {
		this.date = date;
	}
	public boolean isDone() {
		return done;
	}
	public void setDone(boolean done) {
		this.done = done;
	}
	
	public todo() {
		super();
	}
	public todo(int id, String username, String description, LocalDate date, boolean done) {
		super();
		this.id = id;
		this.username = username;
		this.description = description;
		this.date = date;
		this.done = done;
	}
	@Override
	public String toString() {
		return "Todo [id=" + id + ", username=" + username + ", description=" + description + ", date=" + date
				+ ", done=" + done + "]";
	}
}
