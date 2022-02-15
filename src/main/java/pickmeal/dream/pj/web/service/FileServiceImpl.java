package pickmeal.dream.pj.web.service;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.java.Log;
/**
 * 
 * 게시판별로 첨부파일들을 외부경로에 저장한다
 * 		1) 파일 이름 생성
 * 		2) 파일 경로 설정
 * 
 * Issue. 
 * 		window와 
 * 
 * 
 * @author 윤효심
 *
 */
@Service("fileService")
@Log
public class FileServiceImpl implements FileService{
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Resource(name="uploadNoticeBoardPath")
	private String uploadNoticeBoardPath;
	
	@Resource(name="uploadReviewBoardPath")
	private String uploadReviewBoardPath;
	
	@Resource(name="rootPath")
	private String rootPath;
	
	
	
	/**
	 * 
	 * 업로드한 파일들을 서버컴퓨터 외부에 저장
	 * 		1) 서버 컴퓨터별 루트경로에 따른 폴더 경로 설정
	 * 				- window, mac에 따라 다름
	 * 		2) 파일 이름 설정
	 * 				- 게시판이름 + 회원아이디(숫자) + 오늘날짜 + 숫자변수 + 확장자
	 * 
	 */
	@Override
	public List<String> saveImgToExternal(String boardName, List<MultipartFile>files, long memberId) throws Exception{
		
		// 게시물 1개당 업로드한 파일들의 경로 (ex. img src에 들어갈것)
		List<String> imgSrc = new ArrayList<String>();

		//파일 경로 설정
		String imgPath; 	//서버 루트 경로 포함한 파일 경로 ex) /Users/external_resources/
		imgPath = getExternalImgPath(boardName,memberId);
		

		int i = 0;
		for(MultipartFile mf : files) {
		
			//1. 파일 이름 만들어주기 ( 파일이름이 겹칠 수 있어서 )
			String imgName = getFileName(boardName, memberId, i++, mf.getOriginalFilename());
	    	
			//2. 경로 설정 해주기 (파일 경로, 파일 이름)
	    	File imgTarget = new File(imgPath,imgName);
	    		
	    	//3. 경로 없으면 만들어주기
	    	if ( ! new File(imgPath).exists()) {
	            new File(imgPath).mkdirs();

	        }
	    	
	    	//4. 파일 복사
	    	FileCopyUtils.copy( mf.getBytes(), imgTarget);
	 
	    	/*
	    	 * 5. img src 경로 반환 
	    	 * 		- img 태그의 src에는 서버 루트 제외한 경로가 들어간다 
	    	 */
	    	imgSrc.add(getExternalImgPathSubRootPath(imgTarget.toString()));
	    	log.info("이미지 src 경로 : "+getExternalImgPathSubRootPath(imgTarget.toString()));
	    
		}

		return imgSrc;	
		
	}
	
	//서버 루트 경로 제외한 폴더 경로
	private String getExternalImgPathSubRootPath(String imgPath) {
		log.info("context path?"+new File("").getAbsolutePath());
		String tempImgPath =imgPath.split(rootPath)[1];
		return tempImgPath;
	}
	
	//게시판별 이미지 폴더 경로 설정
	private String getExternalImgPath(String boardName, long memberId) {
		String tempImgPath;
		if(boardName.equals("NOTICE")) {
			tempImgPath = uploadNoticeBoardPath + "/" + memberId + "/" + getTodayDate();
		}
		else if(boardName.equals("REVIEW")) {
			tempImgPath = uploadReviewBoardPath + "/" + memberId + "/" + getTodayDate();
		}
		else {
			tempImgPath = uploadPath;
		}
		return rootPath + tempImgPath;
	}
	
	/*
	 * 	파일 이름 설정
	 * 	규칙 : 게시판이름 + 회원아이디(숫자) + 오늘날짜 + 숫자변수 + 확장자
	 */
	private String getFileName(String boardName, long memberId, int i, String fileName) {
		
	    String tempImgName;
	    
	    if(boardName.equals("NOTICE")) {
	    	tempImgName = "n";
	    }
		else if(boardName.equals("REVIEW")) {
			tempImgName = "r";
		}
		else {
			tempImgName ="";
		}
	    
	    tempImgName = tempImgName + memberId + "_" + getTodayDateTime();
	    tempImgName = tempImgName + "_" + i + "." + (fileName.substring(fileName.lastIndexOf(".") + 1));
	    
	    return tempImgName;
	}
	
	
	private String getTodayDate() {
		// 현재 날짜 구하기
		LocalDate now = LocalDate.now();
		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		// 포맷 적용
		String formatedNow = now.format(formatter);
		
		return formatedNow;
	}
	
	private String getTodayDateTime() {
		// 현재 날짜,시간 구하기
		LocalDateTime now = LocalDateTime.now();
		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		// 포맷 적용
		String formatedNow = now.format(formatter);
		
		return formatedNow;
	}
	
	/**
	 * 
	 * 외부경로에 있는 파일들 삭제
	 * 		- 이미지태그의 src 부분을 받아, 서버 루트경로를 붙이고 파일을 찾아 삭제
	 * 
	 */
	@Override
	public boolean removeImgFromExternal(List<String> imgSrc) {
		
		//파일 경로 현재 : \external_resources\board\review\1\20220124\n1_20220124152656_0.jpg
		boolean removeState = false;
		
		for(int i=0;i<imgSrc.size();i++) {
			String imgPath = rootPath + imgSrc.get(i);
			File deleteFile  = new File(imgPath);
			
			// 파일이 존재하는지 체크 존재할경우 true, 존재하지않을경우 false
	        if(deleteFile.exists()) {
	            // 파일을 삭제합니다.
	            deleteFile.delete(); 
	            removeState = true;
	            log.info("파일을 삭제하였습니다.");
	            
	        } else {
	            log.info("파일이 존재하지 않습니다.");
	        }
		}
		return removeState;
	}
	

	
}
