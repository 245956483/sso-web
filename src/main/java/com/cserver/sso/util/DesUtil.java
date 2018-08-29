package com.cserver.sso.util;
import java.io.IOException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
* @author： byy 
* @date : 2018年1月10日 上午11:54:37
* @Description：DES加密 解密算法
*/
public class DesUtil {

    private final static String DES = "DES";
    private final static String ENCODE = "UTF-8";
    private final static String defaultKey = "test1234";

    public static void main(String[] args) throws Exception {
        String data = "123456";
        String d=encrypt(data,defaultKey);
        System.out.println("加密后:"+d);
        System.out.println("解密后:"+decrypt(d,defaultKey));        									
    }

    /**
     * 使用 默认key 加密
     * 
     * @return String
     * @author lifq
     * @date 2015-3-17 下午02:46:43
     */
    public static String encrypt(String data,String Key) throws Exception {
        byte[] bt = encrypt(data.getBytes(ENCODE), Key.getBytes(ENCODE));
        String strs = new BASE64Encoder().encode(bt);
        return strs;
    }

    /**
     * 使用 默认key 解密
     * 
     * @return String
     * @author lifq
     * @date 2015-3-17 下午02:49:52
     */
    public static String decrypt(String data,String key) throws IOException, Exception {
        if (data == null)
            return null;
        BASE64Decoder decoder = new BASE64Decoder();        
        byte[] buf = decoder.decodeBuffer(data);
        byte[] bt = decrypt(buf, key.getBytes(ENCODE));
        return new String(bt, ENCODE);
    }    
    /**
     * Description 根据键值进行加密 
     * @param data
     * @param key
     * 加密键byte数组
     * @return
     * @throws Exception
     */
    private static byte[] encrypt(byte[] data, byte[] key) throws Exception {
        // 生成一个可信任的随机数源
    	//SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");;       
        //secureRandom.setSeed(key);
    	SecureRandom secureRandom = new SecureRandom();
        // 从原始密钥数据创建DESKeySpec对象
        DESKeySpec dks = new DESKeySpec(key);
        // 创建一个密钥工厂，然后用它把DESKeySpec转换成SecretKey对象
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
        SecretKey securekey = keyFactory.generateSecret(dks);
        // Cipher对象实际完成加密操作
        Cipher cipher = Cipher.getInstance(DES);
        // 用密钥初始化Cipher对象
        cipher.init(Cipher.ENCRYPT_MODE, securekey, secureRandom);
        return cipher.doFinal(data);
    }

    /**
     * Description 根据键值进行解密
     * 
     * @param data
     * @param key
     * 加密键byte数组
     * @return
     * @throws Exception
     */
    private static byte[] decrypt(byte[] data, byte[] key) throws Exception {
        // 生成一个可信任的随机数源
        //SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");;       
        //secureRandom.setSeed(key);  
    	SecureRandom secureRandom = new SecureRandom();
    	// 从原始密钥数据创建DESKeySpec对象
        DESKeySpec dks = new DESKeySpec(key);
        // 创建一个密钥工厂，然后用它把DESKeySpec转换成SecretKey对象
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
        SecretKey securekey = keyFactory.generateSecret(dks);
        // Cipher对象实际完成解密操作
        Cipher cipher = Cipher.getInstance(DES);
        // 用密钥初始化Cipher对象
        cipher.init(Cipher.DECRYPT_MODE, securekey, secureRandom);
        return cipher.doFinal(data);
    }
}