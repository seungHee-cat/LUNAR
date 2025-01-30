package project.kr.sys.usr.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import project.kr.review.entity.ReviewVO;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.usr.entity.SysUsrVO;
import project.kr.sys.usr.mapper.SysUsrMapper;

import java.io.File;
import java.util.List;

@Slf4j
@Service
public class SysUsrService {

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    private SysUsrMapper sysUsrMapper;

    /**
     * 유저 정보
     */
    public SysUsrVO getSysUsrDetail(LoginSession vo) {
        return sysUsrMapper.getSysUsrDetail(vo);
    }

    /**
     * 유저 사진 정보
     */
    public SysUsrVO getSysUsrImg(LoginSession vo) {
        return sysUsrMapper.getSysUsrImg(vo);
    }

    /**
     * 프로필 수정
     */
    public int updateUsrProfile(SysUsrVO vo) {
        int result = 1;

        try{
//            String folder = "C:/Users/hello/IdeaProjects/Lunar/src/main/resources/static/img/usr/"; // window
            // String folder = "/Users/shlee/IdeaProjects/Lunar/src/main/resources/static/img/usr/"; // mac
            String folder = "/home/ec2-user/apps/project"; // AWS
            MultipartFile uploadFile = vo.getFile();

            // 파일 크기 제한
            long maxFileSize = 500 * 1024; // 500KB
            if (uploadFile.getSize() > maxFileSize) {
                return -1;
            }
            // 유저 테이블 정보 수정
            sysUsrMapper.updateUsrProfile(vo);

            String originalFilename = uploadFile.getOriginalFilename();
            File saveFile = new File(folder, originalFilename);

            // 유저 상세 테이블 정보 수정
            if(vo.getUsrImg() == null || vo.getUsrImg().isEmpty() || !vo.getUsrImg().equals(originalFilename)) {
                // 이미 등록된 이미지가 있고 새로 이미지를 추가하지 않았을 때
                if(vo.getUsrImg() != null && originalFilename == ""){
                    sysUsrMapper.updateUsrDetailProfile(vo);
                    return 1;
                }

                // 유저 프로필 없을때만 이미지 저장
                try {
                    // 파일 저장
                    uploadFile.transferTo(saveFile);

                    // VO에 이미지 경로 저장
                    vo.setUsrImg(originalFilename);
                } catch (Exception e) {
                    e.printStackTrace();
                    return -1;
                }
            }else if(vo.getUsrImg().equals(originalFilename)){
                // 같은 이름의 파일이 업로드 됐을 경우
                return -2;
            }
            sysUsrMapper.updateUsrDetailProfile(vo);

        }catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /*
     * 회원탈퇴 비밀번호 확인
     */
    public boolean checkPassword(SysUsrVO vo){
        SysUsrVO usr = sysUsrMapper.checkPassword(vo);
        String encodedPassword = usr.getUsrPw();
        return passwordEncoder.matches(vo.getUsrPw(), encodedPassword);
    }

    /*
     * 회원탈퇴 진행
     */
    public int withdrawAccount(SysUsrVO vo) {
        int result = 1;

        try{
            // 유저 테이블 정보 삭제
            sysUsrMapper.withdrawAccount(vo);
        }catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 유저 상세조회 (유저 페이지)
     */
    public SysUsrVO getUsrDetail(SysUsrVO vo) {
        return sysUsrMapper.getUsrDetail(vo);
    }

    /**
     * 리뷰 수 통계
     */
    public Integer getReviewStatCnt(SysUsrVO vo) {
        return sysUsrMapper.getReviewStatCnt(vo);
    }

    /**
     * 코멘트 수 통계
     */
    public Integer getCommentStatCnt(SysUsrVO vo) {
        return sysUsrMapper.getCommentStatCnt(vo);
    }

    /**
     * 평균 별점 통계
     */
    public Double getRatingStatAvg(SysUsrVO vo) {
        return sysUsrMapper.getRatingStatAvg(vo);
    }

    /**
     * 유저 평점 데이터 조회
     */
    public List<ReviewVO> getRatingByUser(SysUsrVO vo) {
        return sysUsrMapper.getRatingByUser(vo);
    }

    /**
     * 클릭한 영화에 대한 평점 조회
     */
    public ReviewVO getRatingOne(SysUsrVO vo) {
        return sysUsrMapper.getRatingOne(vo);
    }

    /**
     * 유저 리뷰 전체 조회
     */
    public List<ReviewVO> getUsrReviewList(SysUsrVO vo) {
        return sysUsrMapper.getUsrReviewList(vo);
    }

    /*
     * 프로필 이미지 삭제
     */
    public int deleteUsrImg(SysUsrVO vo) {
        int result = 1;

        try{
            sysUsrMapper.deleteUsrImg(vo);
        }catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }


}
