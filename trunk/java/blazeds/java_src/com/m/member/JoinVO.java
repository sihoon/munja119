package com.m.member;

import java.io.Serializable;
import java.util.HashMap;

import com.common.util.SLibrary;

public class JoinVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 122L;

	String user_id;
	String passwd;
	String user_name;
	String jumin_no;
	String hp;
	String phone_return;
	String email;
	String emailYN;
	String hpYN;
	

	int rnum;


	String sname;
	String subphone;
	String addid;
	//
	
	
	public void setHashMap(HashMap<String, String> hm){
		
			setSubphone(SLibrary.IfNull(hm, "subphone"));
			setSname(SLibrary.IfNull(hm,"sname"));
			setAddid(SLibrary.IfNull(hm,"addid"));
	
	}
	
	public String getAddid() {
		return addid;
	}
	public void setAddid(String addid) {
		this.addid = addid;
	}
	public String getSname() {	return sname;	}
	public void setSname(String sname) {this.sname = sname;	}
	
	public String getSubphone() {	return subphone;}
	public void setSubphone(String subphone) {	this.subphone = subphone;	}

	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return passwd;
	}
	public void setPassword(String password) {
		this.passwd = password;
	}
	public String getName() {
		return user_name;
	}
	public void setName(String name) {
		this.user_name = name;
	}
	public String getJumin() {
		return jumin_no;
	}
	public void setJumin(String jumin) {
		this.jumin_no = jumin;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getReturnPhone() {
		return phone_return;
	}
	public void setReturnPhone(String returnPhone) {
		this.phone_return = returnPhone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailYN() {
		return emailYN;
	}
	public void setEmailYN(String emailYN) {
		this.emailYN = emailYN;
	}
	public String getHpYN() {
		return hpYN;
	}
	public void setHpYN(String hpYN) {
		this.hpYN = hpYN;
	}
	
	
}
