package pickmeal.dream.pj.message.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import pickmeal.dream.pj.member.domain.Member;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class Alarm {
	private long id;
	private Member member;
	private Member friend;
	private char alarmType;
	private String content;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd hh:mm:ss", timezone="Asia/Seoul")
	private Date regDate;
}
