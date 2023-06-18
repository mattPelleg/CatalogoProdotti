package com.azienda.catalogoProdotti.dao;

import java.util.List;

public interface DaoInterface<T> {
	
	//Metodi crud di base
	
	public void create(T object);
	
	public List<T> retrieve();
	
	public void update(T object);
	
	public void delete(T object);

}
