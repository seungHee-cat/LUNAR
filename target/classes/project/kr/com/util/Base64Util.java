package project.kr.com.util;
import java.util.Base64;

public class Base64Util {

    // Base64 인코딩
    public static String encodeBase64(String input) {
        return Base64.getEncoder().encodeToString(input.getBytes());
    }

    // Base64 복호화
    public static String decodeBase64(String encoded) {
        byte[] decodedBytes = Base64.getDecoder().decode(encoded);
        return new String(decodedBytes);
    }

}

