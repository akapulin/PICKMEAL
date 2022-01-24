package pickmeal.dream.pj.message.command;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AlarmCommand {
	private long id;
	private char alarmType;
	private long memberId;
	private long friendId;
	private String content;
	private String answer;
}
