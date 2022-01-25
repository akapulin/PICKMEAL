package pickmeal.dream.pj.config;
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
	
	@Autowired
	PropertiesConfiguration imgPropertyConfig;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		/*
		 * 
		 * 게시판 파일 업로드 매핑
		 * 
		 * 
		 */
		//window일 때
		registry.addResourceHandler(imgPropertyConfig.getString("file.mappingPath"))
				.addResourceLocations(imgPropertyConfig.getString("file.locationImgPathFromWindow"));
		
		
		//posting관련 이미지 
		//registry.addResourceHandler("/posting/**")
		//.addResourceLocations("/pickmeal/resources/img/posting/");

		

	}


}