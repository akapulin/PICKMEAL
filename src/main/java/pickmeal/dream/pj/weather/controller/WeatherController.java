package pickmeal.dream.pj.weather.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.menu.service.MenuService;
import pickmeal.dream.pj.weather.domain.Forecast;
import pickmeal.dream.pj.weather.domain.MyLocation;
import pickmeal.dream.pj.weather.domain.PickMealWeather;
import pickmeal.dream.pj.weather.domain.Weather;
import pickmeal.dream.pj.weather.service.WeatherService;

@Log
@Controller
public class WeatherController {
	@Autowired
	WeatherService weatherService;
	
	@Autowired
	MenuService menuService;
	
	@GetMapping("/weather")
	public ModelAndView getWeather(@RequestParam("nx") String nx, @RequestParam("ny") String ny) {
		ModelAndView mav = new ModelAndView();

		MyLocation ml = new MyLocation(nx, ny);
		//날씨 - 김재익
		Weather weather = weatherService.getWeather(ml);
		PickMealWeather wc = weatherService.getPickMealTypeWeather(weather);
		Forecast forecast = weatherService.getForecast(ml);
		mav.addObject("weather", wc);
		mav.addObject("forecast", forecast);
		
		menuService.findMenuByWeather(wc);
		
		mav.setViewName("weather/weather");
		
		return mav;
	}
}
