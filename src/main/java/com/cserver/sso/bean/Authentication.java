package com.cserver.sso.bean;
import java.io.Serializable;
/**
* @author： byy 
* @date : 2017年12月5日 下午3:33:15
* @Description：认证表
*/
public class Authentication implements Serializable {
	
	private static final long serialVersionUID = -2632368412476400713L;

	private String id;

	private String login_name;

	private String password;
	
	private String textpass;

	private String password_question;

	private String password_answer;

	private String email;
	
	private String mobile;
	
	private String isValid;
	
	private int state;
	
	private int failureTimes;
	
	private String sockedTime;
	
	private String isSM;
	
	private String firstFailureTimes;
	
	private String attach_login_name;	
	
	
	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public int getFailureTimes() {
		return failureTimes;
	}

	public void setFailureTimes(int failureTimes) {
		this.failureTimes = failureTimes;
	}

	public String getSockedTime() {
		return sockedTime;
	}

	public void setSockedTime(String sockedTime) {
		this.sockedTime = sockedTime;
	}

	public String getIsSM() {
		return isSM;
	}

	public void setIsSM(String isSM) {
		this.isSM = isSM;
	}

	public String getFirstFailureTimes() {
		return firstFailureTimes;
	}

	public void setFirstFailureTimes(String firstFailureTimes) {
		this.firstFailureTimes = firstFailureTimes;
	}

	public Authentication() {
		super();
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTextpass() {
		if(textpass==null) return "";
		return textpass;
	}

	public void setTextpass(String textpass) {
		this.textpass = textpass;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getPassword_question() {
		return password_question;
	}

	public void setPassword_question(String password_question) {
		this.password_question = password_question;
	}

	public String getPassword_answer() {
		return password_answer;
	}

	public void setPassword_answer(String password_answer) {
		this.password_answer = password_answer;
	}

	public String getLogin_name() {
		return login_name;
	}

	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}

	public String getAttach_login_name() {
		return attach_login_name;
	}

	public void setAttach_login_name(String attach_login_name) {
		this.attach_login_name = attach_login_name;
	}
	

}
