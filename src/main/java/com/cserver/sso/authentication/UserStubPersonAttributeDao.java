package com.cserver.sso.authentication;  
  
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.jasig.services.persondir.IPersonAttributes;
import org.jasig.services.persondir.support.AttributeNamedPersonImpl;
import org.jasig.services.persondir.support.StubPersonAttributeDao;
import org.springframework.stereotype.Component;

import com.cserver.sso.bean.Authentication;
import com.cserver.sso.bean.UserDetail;
import com.cserver.sso.util.SaaSUserDaoJdbc;  
   
  
/**
* @author： byy 
* @date : 2017年12月5日 下午2:55:48
* @Description：自定义的返回给客户端相关信息 
*/ 
@Component(value="attributeRepository")  
public class UserStubPersonAttributeDao extends StubPersonAttributeDao {  
    
	@Resource  
    private SaaSUserDaoJdbc userDaoJdbc;  
      
    public IPersonAttributes getPerson(String uid) {  
        Map<String, List<Object>> attributes = new HashMap<String, List<Object>>();  
        try {
        	Authentication authentication=userDaoJdbc.getAuthentication(uid);
        	String username=authentication.getLogin_name();
        	
        	UserDetail user = userDaoJdbc.getUserDetailByUsername(username);
        	if(user!=null){
                attributes.put("realname", Collections.singletonList((Object)URLEncoder.encode(user.getName()!=null?user.getName():"", "UTF-8")));  
                attributes.put("company", Collections.singletonList((Object)URLEncoder.encode(user.getCompany()!=null?user.getCompany():"", "UTF-8")));  
        	}
         } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }  
        return new AttributeNamedPersonImpl(attributes);  
    }  
}