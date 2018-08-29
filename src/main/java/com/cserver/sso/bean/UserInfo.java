package com.cserver.sso.bean;

public class UserInfo {

	private String sessionId;
	private String loginname;
	private String username;
	private String ip;
	private String agent;
	private long onlinetime;
	private long fenzhong;
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getAgent() {
		return agent;
	}
	public void setAgent(String agent) {
		this.agent = agent;
	}
	public long getOnlinetime() {
		return onlinetime;
	}
	public void setOnlinetime(long onlinetime) {
		this.onlinetime = onlinetime;
	}
	public long getFenzhong() {
		return fenzhong;
	}
	public void setFenzhong(long fenzhong) {
		this.fenzhong = fenzhong;
	}
}
