package pickmeal.dream.pj.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import pickmeal.dream.pj.web.service.FileService;

/**
 * 
 * 파일 첨부기능
 * 		- 외부파일에 사용자가 첨부한 파일을 저장해준다.
 * 		- 임의의 경로와, 파일이름을 만들어준다.
 * @author 윤효심
 *
 */
@Controller
public class FileController {

	@Autowired
	FileService fs;
	
	/**
	 * 
	 * 공지사항 게시판 파일들을 외부경로에 저장
	 * 		1) 외부경로에 멤버별 폴더 생성
	 * 		2) 외부경로 리턴
	 * 
	 * @param files
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/saveImgToNoticeBoard")
	@ResponseBody
	public ResponseEntity<?> saveImgToNoticeBoard(List<MultipartFile> files) throws Exception{
		//추후변경
		long memberId=1;
		
		List<String> imgSrc = fs.saveImgToExternal("NOTICE",files, memberId);
		return ResponseEntity.ok(imgSrc);
		
	}
	
	/**
	 * 
	 * 리뷰 게시판 파일들을 외부경로에 저장
	 * 		1) 외부경로에 멤버별 폴더 생성
	 * 		2) 외부경로 리턴
	 * 
	 * @param files
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/saveImgToReviewBoard")
	@ResponseBody
	public ResponseEntity<?> saveImgToReviewBoard(List<MultipartFile> files) throws Exception{
		//추후변경
		long memberId=1;
		
		List<String> imgSrc = fs.saveImgToExternal("REVIEW",files, memberId);
		return ResponseEntity.ok(imgSrc);
		
	}
	
	/**
	 * 이미지 src 삭제
	 * 		- 비동기 정보 요청/응답시 List를 인자로 받아올 때는, value="변수명[]"으로 해야한다!
	 * 		- 이미지 경로에 설정되어 있는 contextPath를 제외시켜준다
	 * @param imgSrc
	 * @return
	 */
	@PostMapping("/removeImg")
	@ResponseBody
	public boolean removeImg(@RequestParam(value="imgSrc[]") List<String> imgSrc, HttpServletRequest request) {		
		String contextPath = request.getContextPath();
		//context path 빼주기
		for(int i=0;i<imgSrc.size();i++) {
			String temp[] = imgSrc.get(i).split(contextPath);
			imgSrc.set(i,temp[1]);
		}
		
		return fs.removeImgFromExternal(imgSrc);

	}
	
	
	
	
	
	
	
	
	
	
}
