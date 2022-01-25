package pickmeal.dream.pj.web.service;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.configuration.PropertiesConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	
	//삭제할때
	@Autowired
	PropertiesConfiguration imgPropertyConfig;

	@Override
	public List<String> saveImgToExternal(String boardName, List<MultipartFile>files, long memberId) throws Exception{
		
		// 게시물 1개당 업로드한 파일들의 경로 (ex. img src에 들어갈것)
		List<String> imgSrc = new ArrayList<String>();

		//파일 경로 설정
		String imgPath;
		if(boardName.equals("NOTICE")) {
			imgPath = uploadNoticeBoardPath + "/" + memberId + "/" + getTodayDate();
		}
		else if(boardName.equals("REVIEW")) {
			imgPath = uploadReviewBoardPath + "/" + memberId + "/" + getTodayDate();
		}
		else {
			imgPath = uploadPath;
		}
		
		//파일 이름 설정
		String imgNamePart = "n" +memberId +"_"+ getTodayDateTime();

		int i = 0;
		for(MultipartFile mf : files) {
			//1. 파일 이름 만들어주기 ( 파일이름이 겹칠 수 있어서 )
			//		규칙 : 게시판이름 + 회원아이디(숫자) + 오늘날짜 + 숫자변수 + 확장자
	    	String imgName = imgNamePart+"_"+(i++)+"."+(mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf(".") + 1));

	    	//2. 경로 설정 해주기 ( 규칙 : 공지사항 게시판 - 사용자이름 - 날짜 )
	    	File imgTarget = new File(imgPath,imgName);
	    	
	    	//3. 경로 없으면 만들어주기
	    	if ( ! new File(imgPath).exists()) {
	            new File(imgPath).mkdirs();
	        }
	    	
	    	//4. 파일 복사
	    	FileCopyUtils.copy( mf.getBytes(), imgTarget);
	 
	    	//5. img src 경로 만들어주기 
	    	imgSrc.add(imgTarget.toString());
	    }
		for(String imgsrc : imgSrc) {
			log.info("imgsrc?"+imgsrc);
		}

		return imgSrc;
		
		
	}
	
	public String getTodayDate() {
		// 현재 날짜 구하기
		LocalDate now = LocalDate.now();
		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		// 포맷 적용
		String formatedNow = now.format(formatter);
		
		return formatedNow;
	}
	
	public String getTodayDateTime() {
		// 현재 날짜,시간 구하기
		LocalDateTime now = LocalDateTime.now();
		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		// 포맷 적용
		String formatedNow = now.format(formatter);
		
		return formatedNow;
	}
	
	@Override
	public boolean removeImgFromExternal(List<String> imgSrc) {
		
		//파일 경로 현재 : \external_resources\board\review\1\20220124\n1_20220124152656_0.jpg
		String externalPath = imgPropertyConfig.getString("file.locationPathFromWindow");
		boolean removeState = false;
		
		for(int i=0;i<imgSrc.size();i++) {

			log.info("파일 경로  : "+externalPath+imgSrc.get(i));
			File deleteFile  = new File(externalPath+imgSrc.get(i));
			
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
