package pickmeal.dream.pj.web.constant;

public enum ReviewIconImgPath {
	BATHROOM("/pickmeal/resources/img/restaurant/review/bathroom.png"),
	KIND("/pickmeal/resources/img/restaurant/review/kind.png"),
	SPECIALDAY("/pickmeal/resources/img/restaurant/review/specialday.png"),
	CLEAN("/pickmeal/resources/img/restaurant/review/clean.png"),
	PARKINIG("/pickmeal/resources/img/restaurant/review/parking.png"),
	GOODGROUP("/pickmeal/resources/img/restaurant/review/goodgroup.png"),
	ALONE("/pickmeal/resources/img/restaurant/review/alone.png"),
	BIG("/pickmeal/resources/img/restaurant/review/big.png"),
	INTERIOR("/pickmeal/resources/img/restaurant/review/interior.png");
	

	private final String getReviewMessage;
	
	ReviewIconImgPath(String reviewMessage){
		getReviewMessage = reviewMessage;
	}
	
	@Override
	public String toString() {
		return getReviewMessage;
	}
}
