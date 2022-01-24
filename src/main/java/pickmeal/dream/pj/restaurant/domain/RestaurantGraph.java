package pickmeal.dream.pj.restaurant.domain;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.web.util.PresentTime;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class RestaurantGraph {
	private Member member;
	private Restaurant restaurant;
	private String age;
	
	public void makeAge() {
		PresentTime pt = new PresentTime();
		int nowY = Integer.parseInt(pt.convertFromDateToString(new Date()).substring(0, 4));
		int memberY = Integer.parseInt(member.getBirth().substring(0, 4));
		
		int ageY = nowY - memberY + 1;
		
		this.age = String.valueOf(ageY);
	}
}
