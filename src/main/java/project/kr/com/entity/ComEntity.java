package project.kr.com.entity;

import lombok.Data;

@Data
public class ComEntity {
    private String regId 		= null;	// 등록자ID
    private String regDt 		= null;	// 등록일시
    private String mdfcId 		= null;	// 수정자ID
    private String mdfDt 		= null;	// 수정일시

}
