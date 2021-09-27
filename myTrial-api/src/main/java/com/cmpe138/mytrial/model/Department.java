package com.cmpe138.mytrial.model;

import java.sql.Date;

public class Department {
	@Override
	public String toString() {
		return "Department [dname=" + dname + ", dnumber=" + dnumber + ", mgrssn=" + mgrssn + ", mgrstartdate="
				+ mgrstartdate + "]";
	}
	private String dname;
	private int dnumber;
	private int mgrssn;
	private Date mgrstartdate;
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public int getDnumber() {
		return dnumber;
	}
	public void setDnumber(int dnumber) {
		this.dnumber = dnumber;
	}
	public int getMgrssn() {
		return mgrssn;
	}
	public void setMgrssn(int mgrssn) {
		this.mgrssn = mgrssn;
	}
	public Date getMgrstartdate() {
		return mgrstartdate;
	}
	public void setMgrstartdate(Date mgrstartdate) {
		this.mgrstartdate = mgrstartdate;
	}
	
}
