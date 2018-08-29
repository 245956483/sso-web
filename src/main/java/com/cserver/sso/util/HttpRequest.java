package com.cserver.sso.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.net.ssl.SSLContext;
import javax.security.cert.CertificateException;
import javax.security.cert.X509Certificate;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;
/**
 * 发送put请求创建docker应用实例
 * @author Admin
 *
 */
public class HttpRequest {
	
	public static String sendPut(String url,String jsonStr){
		CloseableHttpClient httpClient =HttpClients.createDefault();
		String res=null;
		HttpPut method=new HttpPut(url);
		StringEntity strEn=null;
			try {
				strEn = new StringEntity(jsonStr,"utf-8");
				method.setEntity(strEn);
				method.setHeader("Content-Type", "application/json");
				HttpResponse resp=httpClient.execute(method);
				HttpEntity htttEntity= resp.getEntity();
				res=EntityUtils.toString(htttEntity,"utf-8");
				httpClient.close();
			} catch (UnsupportedEncodingException e) {
			
				e.printStackTrace();
			} catch (ClientProtocolException e) {
				
				e.printStackTrace();
			} catch (IOException e) {
				
				e.printStackTrace();
			};
		return res;
	}
	
	public static String sendPost(String url,String jsonStr){
		CloseableHttpClient httpClient =HttpClients.createDefault();
		String res=null;
		HttpPost  method=new HttpPost(url);
		StringEntity strEn=null;
			try {
				strEn = new StringEntity(jsonStr,"utf-8");
				method.setEntity(strEn);
				method.setHeader("Content-Type", "application/x-www-form-urlencoded");
				HttpResponse resp=httpClient.execute(method);
				HttpEntity htttEntity= resp.getEntity();
				res=EntityUtils.toString(htttEntity,"utf-8");
				httpClient.close();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (ClientProtocolException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			};
		return res;
	}
	
	public static String sendGet(String url){
	
		CloseableHttpClient httpClient=HttpClients.createDefault();
		try {
			httpClient = buildSSLCloseableHttpClient();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String res=null;
		HttpGet  method=new HttpGet(url);
			try {
				//strEn = new StringEntity(jsonStr,"utf-8");
				//method.setEntity(strEn);
				method.setHeader("Content-Type", "application/x-www-form-urlencoded");
				HttpResponse resp=httpClient.execute(method);
				HttpEntity htttEntity= resp.getEntity();
				res=EntityUtils.toString(htttEntity,"utf-8");
				httpClient.close();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (ClientProtocolException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			};
		return res;
	}
	
	//http  get请求  返回状态码
	public static int sendGetResCode(String url){
		CloseableHttpClient httpClient =HttpClients.createDefault();
		int resStatusCode=0;
		HttpGet  method=new HttpGet(url);
			try {
				method.setHeader("Content-Type", "application/json");
				HttpResponse resp=httpClient.execute(method);
				//HttpEntity htttEntity= resp.getEntity();
				resStatusCode=resp.getStatusLine().getStatusCode();
				//res=EntityUtils.toString(htttEntity,"utf-8");
				httpClient.close();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (ClientProtocolException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			};
		return resStatusCode;
	}
	
	@SuppressWarnings("deprecation")
	private static CloseableHttpClient buildSSLCloseableHttpClient() throws Exception {
	     SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
		 //信任所有
		 @SuppressWarnings("unused")
		public boolean isTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		     return true;
		 }

		@Override
		public boolean isTrusted(java.security.cert.X509Certificate[] arg0, String arg1)
				throws java.security.cert.CertificateException {
			return true;
		}
	    }).build();
	     SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext, new String[] { "TLSv1" }, null,  
	            SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
	    return HttpClients.custom().setSSLSocketFactory(sslsf).build();
	}
}
