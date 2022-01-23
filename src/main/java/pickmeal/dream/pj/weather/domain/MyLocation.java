package pickmeal.dream.pj.weather.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MyLocation {
	private String nx;
	private String ny;
	
	public MyLocation() {
		
	}
	
	public MyLocation(String nx, String ny) {
		this.nx = nx;
		this.ny = ny;
	}
}
