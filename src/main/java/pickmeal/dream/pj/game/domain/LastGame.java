package pickmeal.dream.pj.game.domain;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.restaurant.domain.Restaurant;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class LastGame {
	private long id;
	private Restaurant restaurant;
	private Member member;
	private Date regDate;
}
