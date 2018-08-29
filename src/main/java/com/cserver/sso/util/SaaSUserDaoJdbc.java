package com.cserver.sso.util;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.jasypt.util.password.StrongPasswordEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cserver.sso.bean.Authentication;
import com.cserver.sso.bean.UserDetail;  
  
/**
* @author： byy 
* @date : 2017年11月22日 下午3:15:20
* @Description：JDBC数据操作帮助类
*/  
@Repository  
public class SaaSUserDaoJdbc {
	//验证账户存在
    private static final String SQL_VERIFY_ACCOUNT = "SELECT COUNT(*) FROM AUTHENTICATION  WHERE lower(login_name)=lower(?) or attach_login_name = ?";  
    //查询用户密码
    private static final String SQL_VERIFY_PASSWORD = "SELECT password FROM AUTHENTICATION  WHERE lower(login_name)=lower(?) ";  
    //获取用户实体
    private static final String SQL_AUTHENTICATION = "SELECT * FROM AUTHENTICATION  WHERE lower(login_name)=lower(?) or attach_login_name = ?";  
    //获取用户详情实体
    private static final String SQL_PT_USER_DETAIL = "SELECT * FROM PT_USER_DETAIL T WHERE T.ID= (SELECT P.ID FROM AUTHENTICATION P WHERE lower(P.login_name)=lower(?))";  
    //验证ACCESSTOKEN是否合法
    private static final String SQL_VERIFY_ACCESSTOKEN = "SELECT COUNT(*) FROM ISV_ACCESS_TOKEN  WHERE ACCESSTOKEN=? and USESTATE='0' and to_date(EXPIREDTIME,'yyyy-mm-dd hh24:mi:ss')>=sysdate";
    //private static final String SQL_VERIFY_ACCESSTOKEN="SELECT COUNT(*) FROM ISV_ACCESS_TOKEN  WHERE ACCESSTOKEN=? and USESTATE='0'";
    
    //验证ACCESSTOKEN是否合法
    private static final String SQL_APPID_ACCESSTOKEN = "SELECT ACCESSTOKEN FROM ISV_ACCESS_TOKEN  WHERE APPID=? and USESTATE='0' and to_date(EXPIREDTIME,'yyyy-mm-dd hh24:mi:ss')>=sysdate";
    
    private static final String SQL_APPID_ACCESSTOKEN_UNCHECK = "SELECT ACCESSTOKEN FROM ISV_ACCESS_TOKEN  WHERE APPID=?";
    //ACCESSTOKEN延期
    private static final String UPDATE_ACCESSTOKEN = "update ISV_ACCESS_TOKEN set CREATEDATE=?, CREATETOKENTIME=? ,EXPIREDTIME=?,CREATESTATE=? where ACCESSTOKEN = ?";
   
    private StrongPasswordEncryptor passwordEncryptor;
    @Autowired
    public void setPasswordEncryptor(StrongPasswordEncryptor passwordEncryptor) {
		this.passwordEncryptor = passwordEncryptor;
	}
    private JdbcTemplate jdbcTemplate;    
    @Resource  
    public void setDataSource(DataSource dataSource){  
        this.jdbcTemplate = new JdbcTemplate(dataSource);  
    }
    /**  
	  
	* 功能： 验证密码是否正确
	  
	* @author baiyuanyuan
	
	* @date   2017年11月22日 下午3:04:00  
	
	* @param        
	  
	* @return   boolean
	
	*/
    public boolean verifyAccount(String username, String password){  
        try{  
            	//验证用户名和密码是否正确  
            if(1==this.jdbcTemplate.queryForObject(SQL_VERIFY_ACCOUNT, new Object[]{username,username}, Integer.class)){               
            	String dbpassword =this.jdbcTemplate.queryForObject(SQL_VERIFY_PASSWORD,  new Object[]{username},String.class);              	            	
            	//使用java提供的jasypt验证密码  
                return passwordEncryptor.checkPassword(password,dbpassword);
            }
            return false;  
          
        }catch(EmptyResultDataAccessException e){ 
            return false;  
        }  
    }
    /**  
	  
	* 功能： 获取Authentication
	  
	* @author baiyuanyuan
	
	* @date   2017年11月22日 下午3:04:38  
	
	* @param        
	  
	* @return   Authentication
	
	*/
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public Authentication getAuthentication(String username){  
        try{  
            //用户认证表信息获取  
            if(1==this.jdbcTemplate.queryForObject(SQL_VERIFY_ACCOUNT, new Object[]{username,username}, Integer.class)){                  
            	Authentication authentication = (Authentication)this.jdbcTemplate.queryForObject(SQL_AUTHENTICATION,  new Object[]{username,username},new BeanPropertyRowMapper(Authentication.class));              	            	            	            	
                return authentication;
            }
            return null;  
          
        }catch(EmptyResultDataAccessException e){ 
            return null;  
        }  
    }
    
    /**  
	  
	* 功能： 更新Authentication表数据
	  
	* @author baiyuanyuan
	
	* @date   2017年11月22日 下午3:12:22  
	
	* @param        
	  
	* @return   
	
	*/
	public Integer updateSQL(String SQL,Object...objects){  
        try{  
	    	int num=this.jdbcTemplate.update(SQL, objects);            	            	            	
	        return num;                       
        }catch(EmptyResultDataAccessException e){ 
            return 0;  
        }  
    }
	 /**  
	  
		* 功能： 根据SQL添加数据
		  
		* @author baiyuanyuan
		
		* @date   2017年11月22日 下午3:12:22  
		
		* @param        
		  
		* @return   
		
		*/
		public boolean saveInfoBySQL(String SQL){  
	        try{  
		    	this.jdbcTemplate.execute(SQL);            	            	            	
		        return true;                       
	        }catch(EmptyResultDataAccessException e){ 
	            return false;  
	        }  
	    }
	/**  
	  
	* 功能： 根据sql返回所查询的信息结果集
	  
	* @author baiyuanyuan
	
	* @date   2017年11月22日 下午3:12:22  
	
	* @param        
	  
	* @return   
	
	*/
	public Map<String, Object> getInfoBySQL(String SQL){ 
		Map<String, Object> map;
        try{  
	    	map=this.jdbcTemplate.queryForMap(SQL);            	            	            	
	        return map;                       
        }catch(EmptyResultDataAccessException e){ 
            return null;  
        }  
    }
	/**  
	  
	* 功能： 获取用户信息详情
	  
	* @author baiyuanyuan
	
	* @date   2017年12月4日 下午1:39:20  
	
	* @param        
	  
	* @return   
	
	*/

	 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public UserDetail getUserDetailByUsername(String username) {
		//SQL_PT_USER_DETAIL
		 try{  
         	//用户认证表信息获取  
		System.out.println("username=="+username);	 
         if(1==this.jdbcTemplate.queryForObject(SQL_VERIFY_ACCOUNT, new Object[]{username,username}, Integer.class)){  
             
			UserDetail userDetail =(UserDetail)this.jdbcTemplate.queryForObject(SQL_PT_USER_DETAIL,  new Object[]{username},new BeanPropertyRowMapper(UserDetail.class));  
         	            	            	            	
            return userDetail;
         }
         return null;  
       
     }catch(EmptyResultDataAccessException e){ 
         return null;  
     } 
	}
	/**  
	  
	* 功能： 验证accesstoken是否合法
	  
	* @author baiyuanyuan
	
	* @date   2018年1月5日 下午7:00:35  
	
	* @param        
	  
	* @return   
	
	*/
	public boolean verifyAccesstoken(String accesstoken){
			
		if("".equals(accesstoken)||accesstoken==null){
			return false;
		}
        try{  
            	//验证ACCESSTOKEN可用  
            if(1==this.jdbcTemplate.queryForObject(SQL_VERIFY_ACCESSTOKEN, new Object[]{accesstoken}, Integer.class)){             	
            	//延期ACCESSTOKEN
            	SimpleDateFormat creatTokenTimeDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        		SimpleDateFormat createDateDf = new SimpleDateFormat("yyyy-MM-dd");
        		long currentTime = System.currentTimeMillis();
        		Date sysDate = new Date(currentTime);
        		Date expiredTime = new Date(currentTime + 7200 * 1000);
        		//创建时间
        		String createDate=createDateDf.format(sysDate);
        		//创建时间
        		String creatTokenTime=creatTokenTimeDf.format(sysDate);
        		//过期时间
        		String expiredTimeS=creatTokenTimeDf.format(expiredTime);
        		//是否使用过
        		String createState="1";
           	
            	this.jdbcTemplate.update(UPDATE_ACCESSTOKEN, new Object[]{createDate,creatTokenTime,expiredTimeS,createState,accesstoken});              	            	            	
            	
            	return true;
            }
            return false;  
          
        }catch(EmptyResultDataAccessException e){ 
            return false;  
        }  
    }
	public String getAccesstoken(String appid){
		
		if("".equals(appid)||appid==null){
			return null;
		}
        try{  
            	//验证ACCESSTOKEN可用  
            if(appid.equals("testappid")){             	
            	//测试环境appid和access_token不做过期判断           	
            	String key=this.jdbcTemplate.queryForObject(SQL_APPID_ACCESSTOKEN_UNCHECK, new Object[]{appid},String.class);              	            	            	
            	
            	return key;
            	
            }else{
            	
            	String key=this.jdbcTemplate.queryForObject(SQL_APPID_ACCESSTOKEN, new Object[]{appid},String.class);              	            	            	
            	
            	return key;
            } 
          
        }catch(EmptyResultDataAccessException e){ 
            return null;  
        }  
    }
	
} 
