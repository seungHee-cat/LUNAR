package project.kr.board.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
public class EditorFileController {

    @Value("${file.upload.folder}")
    private String folder;

    @RequestMapping(value = "/editorImageUpload", produces = "application/json")
    @ResponseBody
    public Map<String, Object> editorImageUpload(@RequestParam("file") MultipartFile multipartFile){
        Map<String, Object> result = new HashMap<>();
        String folderPath = folder;
        String originalFileName = multipartFile.getOriginalFilename();
        String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 확장자

        // 랜덤 UUID+확장자로 저장될 savedFileName
        String savedFileName = UUID.randomUUID() + extension;

        File saveFile = new File(folderPath + savedFileName);

        try {
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, saveFile);
            result.put("url", "/file/images/" + savedFileName);
            result.put("responseCode", "success");

        } catch (IOException e) {
            FileUtils.deleteQuietly(saveFile);	// 실패시 저장된 파일 삭제
            result.put("responseCode", "error");
            e.printStackTrace();
        }

        return result;
    }
}
