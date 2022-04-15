package pickmeal.dream.pj.config;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.mysql.cj.log.Log;

import lombok.extern.slf4j.Slf4j;
/**
 * 
 * Resource Mapping 
 *  내부적으로 사용하는 path를 외부파일 경로로 잡아준다
 * @author 윤효심
 *
 */
@EnableWebMvc
@Configuration
public class WebConfig implements WebMvcConfigurer{
	@Resource(name="rootPath")
	private String rootPath;
	
	@Autowired
	PropertiesConfiguration imgPropertyConfig;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		/*
		 * 
		 * 게시판 파일 업로드 매핑
		 * 	- 서버 운영체제별 외부 파일 경로를 지정해준다.
		 *
		 * ex) 
		 * 		/external_resources/**
		 * 		위와 같은 경로는 
		 * 		/Users/external_resources/로 변경해준다.
		 * 
		 */
	
		registry.addResourceHandler("/external_resources/**")
		//.addResourceLocations("file:///Users/external_resources/");
		//.addResourceLocations("file:///C:/external_resources/");
		.addResourceLocations("file://"+rootPath+"/external_resources/");

	}


}